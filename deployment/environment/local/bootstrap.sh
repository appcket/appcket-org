#!/bin/bash
set -euo pipefail

# This script should be run against a fresh clone of the appcket-org repository.
# It will setup everything for local development (docker compose, building images, Kubernetes secrets and volumes, Helm charts)

# PROJECT_MACHINE_NAME will also be used in creating the database and as the domain name
PROJECT_MACHINE_NAME='appcket'
PROJECT_HUMAN_NAME='Appcket'
DATABASE_USER='dbuser'
DATABASE_PASSWORD='Ch@ng3To@StrongP@ssw0rd'

# You shouldn't need to change anything below unless you have customized these values elsewhere

#----------------------------------------------------------------------------------------------------------

# Keep this during initial setup, and change in Keycloak later if needed for local dev use. Definitely change for production use. See production deployment docs for more information.
API_CLIENT_KEYCLOAK_SECRET='1SMHqsPrhtoxlMPLRYcHP39uJL16oGG1'

# Resolve script directory and repository root so the script works when run from any CWD
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../../.." >/dev/null 2>&1 && pwd)"

# Rename in files to new project name but exclude renaming in this file
echo '---------------------'
echo 'Renaming in files...'

# Use grep to find text files containing the search strings and print results as null-delimited.
# This avoids issues with filenames containing spaces and skips binary files.
grep -IrlZ --exclude='bootstrap.sh' --exclude-dir='.git' -e 'appcket' ../../../ | xargs -0 sed -i "s/appcket/${PROJECT_MACHINE_NAME}/g" || true
grep -IrlZ --exclude='bootstrap.sh' --exclude-dir='.git' -e 'Appcket' ../../../ | xargs -0 sed -i "s/Appcket/${PROJECT_HUMAN_NAME}/g" || true
grep -IrlZ --exclude='bootstrap.sh' --exclude-dir='.git' -e 'Ch@ng3To@StrongP@ssw0rd' ../../../ | xargs -0 sed -i "s/Ch@ng3To@StrongP@ssw0rd/${DATABASE_PASSWORD}/g" || true

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

kubectl label namespace ${PROJECT_MACHINE_NAME} istio.io/dataplane-mode=ambient

kubectl label namespace ${PROJECT_MACHINE_NAME} istio.io/use-waypoint=waypoint

# create necessary secrets
kubectl create secret generic database-secret --from-literal=user=${DATABASE_USER} --from-literal=password=${DATABASE_PASSWORD} -n ${PROJECT_MACHINE_NAME} || true

kubectl create secret generic api-keycloak-client-secret --from-literal=clientsecret=${API_CLIENT_KEYCLOAK_SECRET} -n ${PROJECT_MACHINE_NAME} || true

# Deploy Redpanda Cluster
echo "--------------------"
echo "Deploying Redpanda cluster..."
helm install redpanda "${REPO_ROOT}/deployment/environment/local/helm/redpanda" -f "${REPO_ROOT}/deployment/environment/local/helm/redpanda/values.yaml" -n redpanda

kubectl label namespace redpanda istio.io/dataplane-mode=ambient

# Database setup, create the database, project schema, keycloak schema and insert sample keycloak data
echo '---------------------'
echo 'Create the database and populate Keycloak schema...'

# Check if the database already exists, and create if it doesn't
DB_EXISTS=$(psql -tAc "SELECT 1 FROM pg_database WHERE datname='${PROJECT_MACHINE_NAME}'" "dbname=postgres user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost" || true)
if [ "${DB_EXISTS}" = "1" ]; then
	echo "Database ${PROJECT_MACHINE_NAME} already exists; skipping create"
else
	echo "Creating database ${PROJECT_MACHINE_NAME}..."
	psql -c "CREATE DATABASE ${PROJECT_MACHINE_NAME} WITH ENCODING 'UTF8'" "dbname=postgres user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"
fi

psql -c "CREATE SCHEMA IF NOT EXISTS ${PROJECT_MACHINE_NAME}; CREATE SCHEMA IF NOT EXISTS keycloak" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"
psql -f "${SCRIPT_DIR}/keycloak_dump.sql" "dbname=${PROJECT_MACHINE_NAME} user=${DATABASE_USER} password=${DATABASE_PASSWORD} host=localhost"