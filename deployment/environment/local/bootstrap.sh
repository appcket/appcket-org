#!/bin/bash
set -euo pipefail

# This script should be run against a fresh clone of the appcket-org repository.
# It will setup everything for local development (docker compose, building images, Kubernetes secrets and volumes, Helm charts)

# PROJECT_MACHINE_NAME will also be used in creating the database and as the domain name
PROJECT_MACHINE_NAME='appcket'
PROJECT_HUMAN_NAME='Appcket'
DATABASE_USER='dbuser'
DATABASE_PASSWORD='Ch@ng3To@StrongP@ssw0rd'
CLICKHOUSE_USER='dbuser'
CLICKHOUSE_PASSWORD='Ch@ng3To@StrongP@ssw0rd'

# You shouldn't need to change anything below unless you have customized these values elsewhere

#----------------------------------------------------------------------------------------------------------

# Keep this during initial setup, and change via Keycloak admin console later if needed for local dev use. Definitely change for production use. See production deployment docs for more information.
API_CLIENT_KEYCLOAK_SECRET='1SMHqsPrhtoxlMPLRYcHP39uJL16oGG1'

# Resolve script directory and repository root so the script works when run from any CWD
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../../.." >/dev/null 2>&1 && pwd)"

# Rename in files to new project name but exclude renaming in this file
echo '---------------------'
echo 'Renaming in files...'

# Use grep to find text files containing the search strings and print results as null-delimited.
# This avoids issues with filenames containing spaces and skips binary files.
# Limit search to the repo root and exclude large dirs; show a dry-run count first.
echo "Searching for occurrences in ${REPO_ROOT}..."
grep -Irl --exclude='bootstrap.sh' --exclude-dir='.git' --exclude-dir='node_modules' --exclude-dir='dist' --exclude-dir='build' -e 'appcket' "${REPO_ROOT}" | wc -l

# Portable replacement helper: run sed only when matches are found
replace_if_matches() {
  pattern="$1"
  sed_expr="$2"
  matches=$(grep -Irl --exclude='bootstrap.sh' --exclude-dir='.git' --exclude-dir='node_modules' --exclude-dir='dist' --exclude-dir='build' -e "$pattern" "${REPO_ROOT}" || true)
  if [ -n "$matches" ]; then
    printf "%s" "$matches" | tr '\n' '\0' | xargs -0 sed -i -- "$sed_expr"
  else
    echo "No matches for ${pattern}"
  fi
}

replace_if_matches 'appcket' "s/appcket/${PROJECT_MACHINE_NAME}/g"
replace_if_matches 'Appcket' "s/Appcket/${PROJECT_HUMAN_NAME}/g"
replace_if_matches 'Ch@ng3To@StrongP@ssw0rd' "s|Ch@ng3To@StrongP@ssw0rd|${DATABASE_PASSWORD}|g"

# Rename env files
mv "${REPO_ROOT}/app/dot.env.local" "${REPO_ROOT}/app/.env.local"
mv "${REPO_ROOT}/app/dot.env.production" "${REPO_ROOT}/app/.env.production"
mv "${REPO_ROOT}/marketing/dot.env.local" "${REPO_ROOT}/marketing/.env.local"
mv "${REPO_ROOT}/marketing/dot.env.production" "${REPO_ROOT}/marketing/.env.production"

# Docker setup
echo '---------------------'
echo 'Setting up Docker...'

docker volume create --name ${PROJECT_MACHINE_NAME}-database -d local

docker compose -f "${SCRIPT_DIR}/docker-compose.yml" -p ${PROJECT_MACHINE_NAME} up -d

# Build images and push to local registry
echo '---------------------'
echo 'Building and pushing images...'

chmod +x "${SCRIPT_DIR}/start.sh"
chmod +x "${SCRIPT_DIR}/build.sh"
chmod +x "${SCRIPT_DIR}/trust-local-ca.sh"
"${SCRIPT_DIR}/build.sh" -e local

# Set up for using k8s for local development
echo '---------------------'
echo 'Setting up K8s for local development...'

kubectl create namespace ${PROJECT_MACHINE_NAME} || true

kubectl label namespace ${PROJECT_MACHINE_NAME} istio.io/dataplane-mode=ambient || true

kubectl label namespace ${PROJECT_MACHINE_NAME} istio.io/use-waypoint=waypoint || true

# Configure CoreDNS
"${SCRIPT_DIR}/patch-coredns.sh"

# Create necessary secrets
kubectl create secret generic database-secret --from-literal=user=${DATABASE_USER} --from-literal=password=${DATABASE_PASSWORD} -n ${PROJECT_MACHINE_NAME} || true

kubectl create secret generic api-keycloak-client-secret --from-literal=clientsecret=${API_CLIENT_KEYCLOAK_SECRET} -n ${PROJECT_MACHINE_NAME} || true

kubectl create secret generic clickhouse-secret --from-literal=user=${CLICKHOUSE_USER} --from-literal=password=${CLICKHOUSE_PASSWORD} -n ${PROJECT_MACHINE_NAME} || true

# Deploy Redpanda Cluster
echo "--------------------"
echo "Deploying Redpanda cluster..."
helm install redpanda "${REPO_ROOT}/deployment/environment/local/helm/redpanda" -f "${REPO_ROOT}/deployment/environment/local/helm/redpanda/values.yaml" -n redpanda || true

kubectl label namespace redpanda istio.io/dataplane-mode=ambient || true

# Start Istio Gateway with helm chart
# "istio-system" namespace must match the values.yaml file ingress.namespace value
echo '---------------------'
echo "Starting Istio Gateway..."
helm upgrade --install istio-gateway "${REPO_ROOT}/deployment/environment/local/helm/istio-gateway" \
-n istio-system \
-f "${REPO_ROOT}/deployment/environment/local/helm/istio-gateway/values.yaml" || true

# Apply cert issuer into cluster
kubectl apply -f "${REPO_ROOT}/deployment/environment/local/helm/issuers.yaml" || true

# Copy the root CA secret to the project namespace for local dev use, so api can call accounts service over mTLS
echo "Waiting for root-ca-secret to be available..."
for i in {1..30}; do
    if kubectl get secret root-ca-secret -n cert-manager >/dev/null 2>&1; then
        echo "root-ca-secret found, copying..."
        kubectl get secret root-ca-secret -n cert-manager -o yaml \
        | sed "s/namespace: cert-manager/namespace: ${PROJECT_MACHINE_NAME}/" \
        | kubectl apply -f - || true
        break
    fi
    echo "Waiting for root-ca-secret... ($i/30)"
    sleep 1
done

# run the bootstrap-namespace chart to setup istio related resources for appcket namespace
helm upgrade --install bootstrap-namespace "${REPO_ROOT}/deployment/environment/local/helm/bootstrap-namespace" \
-n ${PROJECT_MACHINE_NAME} \
-f "${REPO_ROOT}/deployment/environment/local/helm/bootstrap-namespace/values-appcket.yaml" || true

# Database setup
#create the databases, project schema, keycloak schema and insert sample keycloak data
echo '---------------------'
echo 'Create the databases and populate Keycloak schema...'

# Check if the main database already exists, and create if it doesn't
DB_EXISTS=$(psql -tAc "SELECT 1 FROM pg_database WHERE datname='${PROJECT_MACHINE_NAME}'" "dbname=postgres user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost" || true)
if [ "${DB_EXISTS}" = "1" ]; then
    echo "Database ${PROJECT_MACHINE_NAME} already exists; skipping create"
else
    echo "Creating database ${PROJECT_MACHINE_NAME}..."
    psql -c "CREATE DATABASE ${PROJECT_MACHINE_NAME} WITH ENCODING 'UTF8'" "dbname=postgres user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"
fi

# Check if the sequin database already exists, and create if it doesn't
DB_EXISTS=$(psql -tAc "SELECT 1 FROM pg_database WHERE datname='sequin'" "dbname=postgres user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost" || true)
if [ "${DB_EXISTS}" = "1" ]; then
    echo "Database sequin already exists; skipping create"
else
    echo "Creating database sequin..."
    psql -c "CREATE DATABASE sequin WITH ENCODING 'UTF8'" "dbname=postgres user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"
fi

# Check if the keycloak database already exists, and create if it doesn't
DB_EXISTS=$(psql -tAc "SELECT 1 FROM pg_database WHERE datname='keycloak'" "dbname=postgres user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost" || true)
if [ "${DB_EXISTS}" = "1" ]; then
    echo "Database keycloak already exists; skipping create"
else
    echo "Creating database keycloak..."
    psql -c "CREATE DATABASE keycloak WITH ENCODING 'UTF8'" "dbname=postgres user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"
fi

psql -c "CREATE SCHEMA IF NOT EXISTS ${PROJECT_MACHINE_NAME}" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"

psql -f "${SCRIPT_DIR}/keycloak_dump.sql" "dbname=keycloak user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"

# Setup Sequin replication slot and publication
echo '---------------------'
echo 'Setting up Sequin replication slot and publication...'

SLOT_EXISTS=$(psql -tAc "SELECT 1 FROM pg_replication_slots WHERE slot_name='sequin_slot'" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost" || true)

if [ "${SLOT_EXISTS}" = "1" ]; then
    echo "Replication slot sequin_slot already exists; skipping create"
else
    echo "Creating replication slot sequin_slot..."
    psql -c "SELECT pg_create_logical_replication_slot('sequin_slot', 'pgoutput')" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"
fi

PUB_EXISTS=$(psql -tAc "SELECT 1 FROM pg_publication WHERE pubname='sequin_pub'" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost" || true)

if [ "${PUB_EXISTS}" = "1" ]; then
    echo "Publication sequin_pub already exists; skipping create"
else
    echo "Creating publication sequin_pub..."

    psql -c "CREATE PUBLICATION sequin_pub FOR ALL TABLES" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"
fi

# Setup ClickHouse
echo '---------------------'
echo 'Setting up ClickHouse...'
chmod +x "${SCRIPT_DIR}/setup-clickhouse.sh"
"${SCRIPT_DIR}/setup-clickhouse.sh"

# Seed Database with sample application data
echo '---------------------'
echo 'Seeding database...'
cd "${REPO_ROOT}/deployment/database"

if ! command -v pnpm &> /dev/null; then
    echo "pnpm could not be found. Please install pnpm to run the seeding script."
    exit 1
fi

echo "Installing database dependencies..."
pnpm install

echo "Running schema refresh and seed..."
export DB_ADDR=localhost DB_PORT=5432 DB_USER=${DATABASE_USER} DB_PASSWORD=${DATABASE_PASSWORD} DB_NAME=${PROJECT_MACHINE_NAME}
pnpm run schema-seed

echo "Running post-seed script..."
pnpm run post-seed

echo "✅ Database seeded successfully."
