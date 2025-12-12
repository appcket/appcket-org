#!/bin/bash
#
# Start everything for a local dev env. This can be used AFTER setting everything up the first time by running the bootrstap.sh script.
# See https://appcket.org/getting-started/installation-initial-setup/
# To be run from the "PROJECT_MACHINE_NAME/deployment/environment/local" folder: ./start.sh

PROJECT_MACHINE_NAME='appcket'

# Resolve script directory and repository root so the script works when run from any CWD
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../../.." >/dev/null 2>&1 && pwd)"
#echo "Using REPO_ROOT=${REPO_ROOT} and SCRIPT_DIR=${SCRIPT_DIR}"

# Create bind mount to share your Ubuntu home dev folder with Rancher Desktop's WSL distro
mkdir -p /mnt/wsl/rancher-desktop-bind-mounts/dev && sudo mount --bind ~/dev /mnt/wsl/rancher-desktop-bind-mounts/dev

# Set kubectl namespace
kubectl config set-context --current --namespace=${PROJECT_MACHINE_NAME}

# Database and Registry containers
echo '---------------------'
echo 'Starting Database and Registry containers...'
docker compose -f "${REPO_ROOT}/deployment/environment/local/docker-compose.yml" -p ${PROJECT_MACHINE_NAME} up --build -d

# Delete existing instance
echo '---------------------'
echo "Deleting ${PROJECT_MACHINE_NAME}..."
helm delete ${PROJECT_MACHINE_NAME} -n ${PROJECT_MACHINE_NAME}

# Create project helm chart
echo '---------------------'
echo "Creating ${PROJECT_MACHINE_NAME} helm package..."
# Package the chart from the repository root, outputting the packaged chart into the repo root
helm package "${REPO_ROOT}/deployment/helm" -d "${REPO_ROOT}/deployment/environment/local"

# Start project with helm chart
echo '---------------------'
echo "Starting ${PROJECT_MACHINE_NAME}..."
helm install ${PROJECT_MACHINE_NAME} "${REPO_ROOT}/deployment/environment/local/${PROJECT_MACHINE_NAME}-0.1.0.tgz" -n ${PROJECT_MACHINE_NAME} -f "${REPO_ROOT}/deployment/helm/values-local.yaml"
