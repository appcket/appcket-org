#!/bin/bash
#
# Start everything for a local WSL local dev env. This can be used AFTER setting everything up the first time. See https://appcket.org/getting-started/installation-initial-setup/.
# Docker backed by WSL must be running before executing this script
# To be run from the "PROJECT_MACHINE_NAME/deployment" folder: ./environment/local/start.sh

PROJECT_MACHINE_NAME='appcket'

ISTIOCTL=istioctl

# Create bind mount
echo '---------------------'
echo 'Creating bind mount...'

sudo mkdir -p /mnt/wsl/docker-desktop-bind-mounts/Ubuntu/dev/${PROJECT_MACHINE_NAME}
sudo mount --bind ~/dev/${PROJECT_MACHINE_NAME} /mnt/wsl/docker-desktop-bind-mounts/Ubuntu/dev/${PROJECT_MACHINE_NAME}

# Database and Registry containers
echo '---------------------'
echo 'Starting Database and Registry containers...'
docker-compose -f ./environment/local/docker-compose.yml -p ${PROJECT_MACHINE_NAME} up --build -d

# Istio
echo '---------------------'
echo 'Starting Istio...'
${ISTIOCTL} install --set profile=default -y
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

# Delete existing instance
echo '---------------------'
echo 'Deleting ${PROJECT_MACHINE_NAME}...'
helm delete ${PROJECT_MACHINE_NAME} -n ${PROJECT_MACHINE_NAME}

# Create project helm chart
echo '---------------------'
echo 'Creating ${PROJECT_MACHINE_NAME} helm package...'
helm package helm

# Start project with helm chart
echo '---------------------'
echo 'Starting ${PROJECT_MACHINE_NAME}...'
helm install ${PROJECT_MACHINE_NAME} ${PROJECT_MACHINE_NAME}-0.1.0.tgz -n ${PROJECT_MACHINE_NAME} -f helm/values-local.yaml
