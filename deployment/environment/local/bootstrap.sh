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
docker volume create --name ${PROJECT_MACHINE_NAME}-registry-data -d local
docker volume create --name ${PROJECT_MACHINE_NAME}-clickhouse-data -d local

docker compose -f "${SCRIPT_DIR}/docker-compose.yml" -p ${PROJECT_MACHINE_NAME} up -d

# Build images and push to local registry
echo '---------------------'
echo 'Building and pushing images...'

chmod +x "${SCRIPT_DIR}/start.sh"
chmod +x "${SCRIPT_DIR}/build.sh"
chmod +x "${SCRIPT_DIR}/trust-local-ca.sh"
chmod +x "${SCRIPT_DIR}/patch-coredns.sh"
chmod +x "${SCRIPT_DIR}/setup-clickhouse.sh"
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

# Force recreate the replication slot to ensure a fresh start
echo "Dropping replication slot sequin_slot if it exists..."
# First, terminate any process actively using the slot so we can drop it
psql -c "SELECT pg_terminate_backend(active_pid) FROM pg_replication_slots WHERE slot_name = 'sequin_slot';" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost" || true
# Now drop the slot
psql -c "SELECT pg_drop_replication_slot('sequin_slot') WHERE EXISTS (SELECT 1 FROM pg_replication_slots WHERE slot_name = 'sequin_slot');" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost" || true

echo "Creating replication slot sequin_slot..."
psql -c "SELECT pg_create_logical_replication_slot('sequin_slot', 'pgoutput')" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"

# Force recreate the publication
echo "Dropping publication sequin_pub if it exists..."
psql -c "DROP PUBLICATION IF EXISTS sequin_pub" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"

echo "Creating publication sequin_pub..."
psql -c "CREATE PUBLICATION sequin_pub FOR ALL TABLES" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"

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

# # Setup Observability
# echo '---------------------'
# echo 'Setting up observability tools...'

# # 1. Create the namespace:
# kubectl create namespace observability --dry-run=client -o yaml | kubectl apply -f -

# # 2. Install Loki (Log Storage):
# helm upgrade --install loki grafana/loki \
# --namespace observability \
# -f "${REPO_ROOT}/deployment/environment/local/helm/observability/values-loki.yaml"

# # 3. Install Promtail (Log Shipping):
# helm upgrade --install promtail grafana/promtail \
# --namespace observability \
# -f "${REPO_ROOT}/deployment/environment/local/helm/observability/values-promtail.yaml"

# # 4. Install Grafana (Dashboard to query and view logs):
# helm upgrade --install grafana grafana/grafana \
# --namespace observability \
# -f "${REPO_ROOT}/deployment/environment/local/helm/observability/values-grafana.yaml"

# # 5. Install Kiali (Mesh Visualization):
# helm upgrade --install kiali-server kiali/kiali-server \
# --namespace observability \
# -f "${REPO_ROOT}/deployment/environment/local/helm/observability/values-kiali.yaml"

# # 6. Install Prometheus (Metrics):
# helm upgrade --install prometheus prometheus-community/prometheus \
# --namespace observability \
# -f "${REPO_ROOT}/deployment/environment/local/helm/observability/values-prometheus.yaml"

#   Once these commands finish, all pods in the observability namespace should be running.

#   Accessing the Dashboards

#   To access the UIs, you can use port-forwarding:

#    * Grafana: kubectl port-forward svc/grafana -n observability 3000:80
#       * http://localhost:3000 (User: admin, Password: admin)
#    * Kiali: kubectl port-forward svc/kiali -n observability 20001:20001
#       * http://localhost:20001

# Option 1: The "Pause" (Scale to 0)
# Run these commands to stop the heavy hitters:

#   1 # Scale down Deployments
#   2 kubectl scale deployment prometheus-server -n observability --replicas=0
#   3 kubectl scale deployment prometheus-prometheus-pushgateway -n observability --replicas=0
#   4 kubectl scale deployment prometheus-kube-state-metrics -n observability --replicas=0
#   5 kubectl scale deployment grafana -n observability --replicas=0
#   6 kubectl scale deployment kiali -n observability --replicas=0
#   7
#   8 # Scale down Loki (StatefulSet)
#   9 kubectl scale statefulset loki -n observability --replicas=0

# Note: `promtail` is a DaemonSet, so it doesn't support scaling to 0. It uses very little RAM, but if you want it gone too, you should use Option 2.

# To spin them back up later:
# Just run the same commands but change --replicas=0 to --replicas=1.

# ---

# Option 2: The "Clean Slate" (Uninstall)
# If you aren't planning on using them for a while, just uninstall the Helm releases. Since we used ephemeral storage (no PVCs), this will completely wipe their footprint:

#   1 helm uninstall prometheus loki promtail grafana kiali-server -n observability