#!/bin/bash
#
# build nodejs apps for production
# usage: $ ./build.sh -e production

ENV=production

# Resolve script directory and repository root so this script works when run from any CWD
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../../.." >/dev/null 2>&1 && pwd)"
echo "Using REPO_ROOT=${REPO_ROOT} and SCRIPT_DIR=${SCRIPT_DIR}"

while getopts e: option
do
case "${option}"
in
e) ENV=${OPTARG};;

esac
done

echo '--------------------------'
echo "|Building for $ENV..."
echo '--------------------------'

# if local, build appcket_nodejs
if [[ "$ENV" = "local" ]]; then
    echo '---------------------'
    echo 'Building nodejs base image...'
    cd "${SCRIPT_DIR}/base-images/nodejs"
    docker buildx build -t localhost:5000/appcket_nodejs:v0.0.1 .
    docker push localhost:5000/appcket_nodejs:v0.0.1
    cd "${REPO_ROOT}"
fi

echo '---------------------'
echo 'Building api image...'
cd "${REPO_ROOT}/api"
docker buildx build --build-arg env=${ENV} -t localhost:5000/appcket_api:v0.0.1 .
if [[ "$ENV" = "local" ]]; then
    docker push localhost:5000/appcket_api:v0.0.1
fi

echo '---------------------'
echo 'Building app image...'
cd "${REPO_ROOT}/app"
docker buildx build --build-arg env=${ENV} -t localhost:5000/appcket_app:v0.0.1 .
if [[ "$ENV" = "local" ]]; then
    docker push localhost:5000/appcket_app:v0.0.1
fi

echo '---------------------'
echo 'Building marketing image...'
cd "${REPO_ROOT}/marketing"
docker buildx build --build-arg env=${ENV} -t localhost:5000/appcket_marketing:v0.0.1 .
if [[ "$ENV" = "local" ]]; then
    docker push localhost:5000/appcket_marketing:v0.0.1
fi

echo '---------------------'
echo 'Building accounts image...'
cd "${REPO_ROOT}/accounts"
docker buildx build -t localhost:5000/appcket_accounts:v0.0.1 .
if [[ "$ENV" = "local" ]]; then
    docker push localhost:5000/appcket_accounts:v0.0.1
fi