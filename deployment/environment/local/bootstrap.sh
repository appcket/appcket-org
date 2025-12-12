#!/bin/bash
set -euo pipefail

# This script should be run against a fresh clone of the appcket-org repository.
# It will setup everything for local development (docker compose, building images, Kubernetes secrets and volumes, Helm charts)

# PROJECT_MACHINE_NAME will also be used in creating the database and as the domain name
PROJECT_MACHINE_NAME='appcket'
PROJECT_HUMAN_NAME='Appcket'
# DATABASE_PASSWORD
DATABASE_PASSWORD='Ch@ng3To@StrongP@ssw0rd'

# This is specific to a Windows and WSL host environment, if using Linux or Mac as your main host, change to: mkcert
MKCERT='mkcert.exe'

# You shouldn't need to change anything below unless you have customized these values elsewhere

#----------------------------------------------------------------------------------------------------------

# Keep this during initial setup, and change in Keycloak later if needed for local dev use. Definitely change for production use. See production deployment docs for more information.
API_CLIENT_KEYCLOAK_SECRET='1SMHqsPrhtoxlMPLRYcHP39uJL16oGG1'

CERTS_DIR="${SCRIPT_DIR}/certs/"
mkdir -p "${CERTS_DIR}"

# Rename in files to new project name but exclude renaming in this file
echo '---------------------'
echo 'Renaming in files...'

# Use grep to find text files containing the search strings and print results as null-delimited.
# This avoids issues with filenames containing spaces and skips binary files.
grep -IrlZ --exclude='bootstrap.sh' --exclude-dir='.git' -e 'appcket' ../../../ | xargs -0 sed -i "s/appcket/${PROJECT_MACHINE_NAME}/g" || true
grep -IrlZ --exclude='bootstrap.sh' --exclude-dir='.git' -e 'Appcket' ../../../ | xargs -0 sed -i "s/Appcket/${PROJECT_HUMAN_NAME}/g" || true
grep -IrlZ --exclude='bootstrap.sh' --exclude-dir='.git' -e 'Ch@ng3To@StrongP@ssw0rd' ../../../ | xargs -0 sed -i "s/Ch@ng3To@StrongP@ssw0rd/${DATABASE_PASSWORD}/g" || true

# Create certs
echo '---------------------'
echo 'Creating local certs...'

# Each subdomain gets own cert, recommended to do it this way instead of a wildcard cert
if command -v "${MKCERT}" >/dev/null 2>&1; then
	(cd "${SCRIPT_DIR}" && ${MKCERT} ${PROJECT_MACHINE_NAME}.localhost)
	(cd "${SCRIPT_DIR}" && ${MKCERT} api.${PROJECT_MACHINE_NAME}.localhost)
	(cd "${SCRIPT_DIR}" && ${MKCERT} app.${PROJECT_MACHINE_NAME}.localhost)
	(cd "${SCRIPT_DIR}" && ${MKCERT} accounts.${PROJECT_MACHINE_NAME}.localhost)
else
	echo "mkcert binary '${MKCERT}' not found in PATH; skipping certificate generation"
fi

# Move to certs directory
if [ -d "${CERTS_DIR}" ]; then
	mv "${SCRIPT_DIR}/${PROJECT_MACHINE_NAME}.localhost.pem" "${SCRIPT_DIR}/${PROJECT_MACHINE_NAME}.localhost-key.pem" "${CERTS_DIR}" || true
	mv "${SCRIPT_DIR}/api.${PROJECT_MACHINE_NAME}.localhost.pem" "${SCRIPT_DIR}/api.${PROJECT_MACHINE_NAME}.localhost-key.pem" "${CERTS_DIR}" || true
	mv "${SCRIPT_DIR}/app.${PROJECT_MACHINE_NAME}.localhost.pem" "${SCRIPT_DIR}/app.${PROJECT_MACHINE_NAME}.localhost-key.pem" "${CERTS_DIR}" || true
	mv "${SCRIPT_DIR}/accounts.${PROJECT_MACHINE_NAME}.localhost.pem" "${SCRIPT_DIR}/accounts.${PROJECT_MACHINE_NAME}.localhost-key.pem" "${CERTS_DIR}" || true
else
	echo "CERTS_DIR ${CERTS_DIR} missing, skipping move of generated certs"
fi

cp ${CERTS_DIR}accounts.${PROJECT_MACHINE_NAME}.localhost.pem ../../../accounts/tls.crt
cp ${CERTS_DIR}accounts.${PROJECT_MACHINE_NAME}.localhost-key.pem ../../../accounts/tls.key
chmod 0644 ../../../accounts/tls.key

cp ${CERTS_DIR}${PROJECT_MACHINE_NAME}.localhost.pem ../../../marketing/certs/tls.crt
cp ${CERTS_DIR}${PROJECT_MACHINE_NAME}.localhost-key.pem ../../../marketing/certs/tls.key
chmod 0644 ../../../marketing/certs/tls.key

# Find root CA file and copy/rename to api/certs
echo '---------------------'
echo 'Copying mkcert root CA to api/certs...'

# Get CAROOT from mkcert and normalize it for WSL if necessary
CAROOT_RAW=$(${MKCERT} -CAROOT 2>/dev/null || true)
if [ -z "$CAROOT_RAW" ]; then
	echo "Error: mkcert -CAROOT returned empty output" >&2
	exit 1
fi

# Convert backslashes to forward slashes (Windows output) and ensure a slash after drive letter
CAROOT_SLASHES=$(echo "$CAROOT_RAW" | sed 's|\\\\|/|g' | sed 's|\\|/|g')
if [[ "$CAROOT_SLASHES" =~ ^([A-Za-z]):[^/] ]]; then
	# Insert slash after drive colon if missing
	DRIVE_LETTER=${BASH_REMATCH[1]}
	REST=${CAROOT_SLASHES:2}
	CAROOT_SLASHES="${DRIVE_LETTER}:/$REST"
fi

# If we have a Windows drive path like C:/..., convert to /mnt/c/... for WSL
if echo "$CAROOT_SLASHES" | grep -qE '^[A-Za-z]:/'; then
	DRIVE=$(echo "$CAROOT_SLASHES" | cut -d: -f1 | tr '[:upper:]' '[:lower:]')
	REST=$(echo "$CAROOT_SLASHES" | cut -d: -f2)
	REST=$(echo "$REST" | sed 's|^/*||')
	CAROOT_WSL="/mnt/${DRIVE}/${REST}"
	ROOTCA_PATH="${CAROOT_WSL}/rootCA.pem"
else
	ROOTCA_PATH="${CAROOT_SLASHES}/rootCA.pem"
fi

echo "Using mkcert root CA path: ${ROOTCA_PATH}"
if [ ! -f "${ROOTCA_PATH}" ]; then
	echo "Error: rootCA.pem not found at ${ROOTCA_PATH}" >&2
	exit 1
fi

cp "${ROOTCA_PATH}" -t "${REPO_ROOT}/api/certs"
mv "${REPO_ROOT}/api/certs/rootCA.pem" "${REPO_ROOT}/api/certs/rootCA.crt"

cp "${CERTS_DIR}api.${PROJECT_MACHINE_NAME}.localhost.pem" "${REPO_ROOT}/api/certs/api.tls.crt"
cp "${CERTS_DIR}api.${PROJECT_MACHINE_NAME}.localhost-key.pem" "${REPO_ROOT}/api/certs/api.tls.key"

cp "${CERTS_DIR}accounts.${PROJECT_MACHINE_NAME}.localhost.pem" "${REPO_ROOT}/api/certs/accounts.tls.crt"
cp "${CERTS_DIR}accounts.${PROJECT_MACHINE_NAME}.localhost-key.pem" "${REPO_ROOT}/api/certs/accounts.tls.key"

cp "${CERTS_DIR}app.${PROJECT_MACHINE_NAME}.localhost.pem" "${REPO_ROOT}/app/certs/app.tls.crt"
cp "${CERTS_DIR}app.${PROJECT_MACHINE_NAME}.localhost-key.pem" "${REPO_ROOT}/app/certs/app.tls.key"

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
"${SCRIPT_DIR}/build.sh" -e local

# Set up for using k8s for local development
echo '---------------------'
echo 'Setting up K8s for local development...'

# Delete any previous configmaps named coredns
# TODO: multiple projects able to run at a time
kubectl delete configmap coredns -n kube-system || true

kubectl create namespace ${PROJECT_MACHINE_NAME} || true

kubectl create secret generic database-secret --from-literal=user=dbuser --from-literal=password=${DATABASE_PASSWORD} -n ${PROJECT_MACHINE_NAME} || true

kubectl create secret generic api-keycloak-client-secret --from-literal=clientsecret=${API_CLIENT_KEYCLOAK_SECRET} -n ${PROJECT_MACHINE_NAME} || true

# Database setup, create the database, project schema, keycloak schema and insert sample keycloak data
echo '---------------------'
echo 'Setting up Keycloak schema...'

# Check if the database already exists, and create if it doesn't
DB_EXISTS=$(psql -tAc "SELECT 1 FROM pg_database WHERE datname='${PROJECT_MACHINE_NAME}'" "dbname=postgres user=dbuser password=${DATABASE_PASSWORD} host=localhost" || true)
if [ "${DB_EXISTS}" = "1" ]; then
	echo "Database ${PROJECT_MACHINE_NAME} already exists; skipping create"
else
	echo "Creating database ${PROJECT_MACHINE_NAME}..."
	psql -c "CREATE DATABASE ${PROJECT_MACHINE_NAME} WITH ENCODING 'UTF8'" "dbname=postgres user=dbuser password=${DATABASE_PASSWORD} host=localhost"
fi

psql -c "CREATE SCHEMA IF NOT EXISTS ${PROJECT_MACHINE_NAME}; CREATE SCHEMA IF NOT EXISTS keycloak" "dbname=${PROJECT_MACHINE_NAME} user=dbuser password=${DATABASE_PASSWORD} host=localhost"
psql -f "${SCRIPT_DIR}/keycloak_dump.sql" "dbname=${PROJECT_MACHINE_NAME} user=dbuser password=${DATABASE_PASSWORD} host=localhost"
