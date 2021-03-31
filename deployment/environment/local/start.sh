#!/bin/bash
#
# Start everything for a local WSL local dev env. This can be used AFTER setting everything up the first time. See README.
# Docker backed by WSL must be running before executing this script
# To be run from the "appcket/deployment" folder: ./environment/local/start.sh

# Create bind mount
echo '---------------------'
echo 'Creating bind mount...'
# CHANGE PATHS based on your directory structure!
sudo mount --bind /home/ryan/dev/appcket /mnt/wsl/docker-desktop-bind-mounts/Ubuntu/dev/appcket

# Database and Registry containers
echo '---------------------'
echo 'Starting Database and Registry containers...'
docker-compose -f ./environment/local/docker-compose.yml -p appcket up --build -d

# Istio
echo '---------------------'
echo 'Starting Istio, setting local ENV vars...'
istioctl.exe manifest install -y
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

# Delete existing appcket instance
echo '---------------------'
echo 'Deleting appcket...'
helm delete appcket -n appcket

# Create appcket helm chart
echo '---------------------'
echo 'Creating appcket helm package...'
helm package helm

# Start appcket with helm chart
echo '---------------------'
echo 'Starting appcket...'
helm install appcket appcket-0.1.0.tgz -n appcket -f helm/values-local.yaml
