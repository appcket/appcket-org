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
helm package "${REPO_ROOT}/deployment/environment/local/helm/appcket" -d "${REPO_ROOT}/deployment/environment/local"

# Start project with helm chart
echo '---------------------'
echo "Starting ${PROJECT_MACHINE_NAME}..."
helm install ${PROJECT_MACHINE_NAME} "${REPO_ROOT}/deployment/environment/local/${PROJECT_MACHINE_NAME}-0.1.0.tgz" -n ${PROJECT_MACHINE_NAME} -f "${REPO_ROOT}/deployment/environment/local/helm/appcket/values.yaml"


# # Observability setup
# 1. Create the namespace:

# kubectl create namespace observability --dry-run=client -o yaml | kubectl apply -f -

# 2. Install Prometheus (Metrics):

# helm upgrade --install prometheus prometheus-community/prometheus \
# --namespace observability \
# -f deployment/helm/observability/values-prometheus.yaml

# 3. Install Loki (Log Storage):

# helm upgrade --install loki grafana/loki \
# --namespace observability \
# -f deployment/helm/observability/values-loki.yaml

# 4. Install Promtail (Log Shipping):

# helm upgrade --install promtail grafana/promtail \
# --namespace observability \
# -f deployment/helm/observability/values-promtail.yaml

# 5. Install Grafana (Dashboards):

# helm upgrade --install grafana grafana/grafana \
# --namespace observability \
# -f deployment/helm/observability/values-grafana.yaml

# 6. Install Kiali (Mesh Visualization):

# helm upgrade --install kiali-server kiali/kiali-server \
# --namespace observability \
# -f deployment/helm/observability/values-kiali.yaml

#   Once these commands finish, all pods in the observability namespace should be running.

#   Accessing the Dashboards

#   To access the UIs, you can use port-forwarding:

#    * Kiali: kubectl port-forward svc/kiali -n observability 20001:20001 -> http://localhost:20001
#    * Grafana: kubectl port-forward svc/grafana -n observability 3000:80 -> http://localhost:3000 (User: admin, Password: admin)

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
