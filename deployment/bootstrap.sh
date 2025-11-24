#!/bin/bash

# This script should be run against a fresh clone of the appcket-org repository.
# It will setup everything for local development (docker compose, building images, Kubernetes secrets and volumes, Helm charts)

# PROJECT_MACHINE_NAME will also be used in creating the database and as the domain name
PROJECT_MACHINE_NAME='appcket'
PROJECT_HUMAN_NAME='Appcket'
DATABASE_PASSWORD='Ch@ng3To@StrongP@ssw0rd'

# You shouldn't need to change anything below unless you have customized these values elsewhere
CERTS_DIR='./environment/local/certs/'
API_CLIENT_KEYCLOAK_SECRET='1SMHqsPrhtoxlMPLRYcHP39uJL16oGG1'

ISTIOCTL=istioctl

# Rename in files to new project name but exlude renaming in this file
echo '---------------------'
echo 'Renaming in files...'

find ../ -type f -name '*' ! -name 'bootstrap.sh' | xargs sed -i  "s/appcket/${PROJECT_MACHINE_NAME}/g"
find ../ -type f -name '*' ! -name 'bootstrap.sh' | xargs sed -i  "s/Appcket/${PROJECT_HUMAN_NAME}/g"
find ../ -type f -name '*' ! -name 'bootstrap.sh' | xargs sed -i  "s/Ch@ng3To@StrongP@ssw0rd/${DATABASE_PASSWORD}/g"

# Create certs
echo '---------------------'
echo 'Creating local certs...'

#each subdomain gets own cert, had problems with wildcard cert and istio tls gateway/virtualservice routing
mkcert ${PROJECT_MACHINE_NAME}.localhost
mkcert api.${PROJECT_MACHINE_NAME}.localhost
mkcert app.${PROJECT_MACHINE_NAME}.localhost
mkcert accounts.${PROJECT_MACHINE_NAME}.localhost

# move to certs directory
mv ${PROJECT_MACHINE_NAME}.localhost.pem ${PROJECT_MACHINE_NAME}.localhost-key.pem ${CERTS_DIR}
mv api.${PROJECT_MACHINE_NAME}.localhost.pem api.${PROJECT_MACHINE_NAME}.localhost-key.pem ${CERTS_DIR}
mv app.${PROJECT_MACHINE_NAME}.localhost.pem app.${PROJECT_MACHINE_NAME}.localhost-key.pem ${CERTS_DIR}
mv accounts.${PROJECT_MACHINE_NAME}.localhost.pem accounts.${PROJECT_MACHINE_NAME}.localhost-key.pem ${CERTS_DIR}

cp ${CERTS_DIR}accounts.${PROJECT_MACHINE_NAME}.localhost.pem ../accounts/tls.crt
cp ${CERTS_DIR}accounts.${PROJECT_MACHINE_NAME}.localhost-key.pem ../accounts/tls.key
chmod 0644 ../accounts/tls.key

cp ${CERTS_DIR}${PROJECT_MACHINE_NAME}.localhost.pem ../marketing/certs/tls.crt
cp ${CERTS_DIR}${PROJECT_MACHINE_NAME}.localhost-key.pem ../marketing/certs/tls.key
chmod 0644 ../marketing/certs/tls.key

# find root CA file and copy/rename to api/certs
mkcert -CAROOT | awk '{print $1"/rootCA.pem"}' | xargs cp -t ../api/certs
mv ../api/certs/rootCA.pem ../api/certs/rootCA.crt

cp ${CERTS_DIR}api.${PROJECT_MACHINE_NAME}.localhost.pem ../api/certs/api.tls.crt
cp ${CERTS_DIR}api.${PROJECT_MACHINE_NAME}.localhost-key.pem ../api/certs/api.tls.key

cp ${CERTS_DIR}accounts.${PROJECT_MACHINE_NAME}.localhost.pem ../api/certs/accounts.tls.crt
cp ${CERTS_DIR}accounts.${PROJECT_MACHINE_NAME}.localhost-key.pem ../api/certs/accounts.tls.key

cp ${CERTS_DIR}app.${PROJECT_MACHINE_NAME}.localhost.pem ../app/certs/app.tls.crt
cp ${CERTS_DIR}app.${PROJECT_MACHINE_NAME}.localhost-key.pem ../app/certs/app.tls.key

# Rename env files
mv ../deployment/database/dot.env.local ../deployment/database/.env.local
mv ../api/dot.env ../api/.env
mv ../app/dot.env.local ../app/.env.local
mv ../app/dot.env.production ../app/.env.production
mv ../marketing/dot.env.local ../marketing/.env.local
mv ../marketing/dot.env.production ../marketing/.env.production

# Docker setup
echo '---------------------'
echo 'Setting up Docker...'

docker volume create --name ${PROJECT_MACHINE_NAME}-database -d local

docker compose -f ./environment/local/docker-compose.yml -p ${PROJECT_MACHINE_NAME} up -d

# Build images and push to local registry
echo '---------------------'
echo 'Building and pushing images...'

chmod +x ./environment/local/start.sh
chmod +x ./build.sh
./build.sh -e local

# Set up for using k8s for local development
echo '---------------------'
echo 'Setting up K8s for local development...'

# Delete any previous configmaps named coredns
# TODO: multiple projects able to run on same host at a time
kubectl delete configmap coredns -n kube-system

kubectl create namespace ${PROJECT_MACHINE_NAME}

kubectl create secret generic database-secret --from-literal=user=dbuser --from-literal=password=${DATABASE_PASSWORD} -n ${PROJECT_MACHINE_NAME}

kubectl create secret generic api-keycloak-client-secret --from-literal=clientsecret=${API_CLIENT_KEYCLOAK_SECRET} -n ${PROJECT_MACHINE_NAME}

# Install istio
# Since we are using k3s, need to set the value: https://istio.io/latest/docs/ambient/install/platform-prerequisites/#k3s
${ISTIOCTL} install --set profile=ambient --set values.global.platform=k3s --skip-confirmation

kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/experimental-install.yaml

# Database setup, create the database, project schema, keycloak schema and insert sample keycloak data
echo '---------------------'
echo 'Setting up Keycloak schema...'

psql -c "CREATE DATABASE ${PROJECT_MACHINE_NAME} WITH ENCODING 'UTF8'" "dbname=${PROJECT_MACHINE_NAME} user=dbuser password=${DATABASE_PASSWORD} host=localhost"
psql -c "CREATE SCHEMA IF NOT EXISTS ${PROJECT_MACHINE_NAME}; CREATE SCHEMA IF NOT EXISTS keycloak" "dbname=${PROJECT_MACHINE_NAME} user=dbuser password=${DATABASE_PASSWORD} host=localhost"
psql -f ./environment/local/keycloak_dump.sql "dbname=${PROJECT_MACHINE_NAME} user=dbuser password=${DATABASE_PASSWORD} host=localhost"
