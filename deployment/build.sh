#!/bin/bash
#
# build nodejs apps for production
# usage: $ ./build.sh -e production

ENV=production

while getopts e: option
do
case "${option}"
in
e) ENV=${OPTARG};;
e) NODE_ENV=${OPTARG};;
esac
done

echo '--------------------------'
echo "|Building for $ENV..."
echo '--------------------------'

# if local, build appcket_nodejs
if [[ "$ENV" = "local" ]]; then
    echo '---------------------'
    echo 'Building nodejs base image...'
    cd ./environment/local/base-images/nodejs
    docker build -t localhost:5000/appcket_nodejs:v0.0.1 .
    docker push localhost:5000/appcket_nodejs:v0.0.1
    cd ../../../../
fi

echo '---------------------'
echo 'Building api image...'
cd ../api
docker build --build-arg env=${ENV} -t localhost:5000/appcket_api:v0.0.1 .
docker push localhost:5000/appcket_api:v0.0.1

echo '---------------------'
echo 'Building app image...'
cd ../app
docker build --build-arg env=${ENV} -t localhost:5000/appcket_app:v0.0.1 .
docker push localhost:5000/appcket_app:v0.0.1

echo '---------------------'
echo 'Building marketing image...'
cd ../marketing
docker build --build-arg env=${ENV} -t localhost:5000/appcket_marketing:v0.0.1 .
docker push localhost:5000/appcket_marketing:v0.0.1

echo '---------------------'
echo 'Building accounts image...'
cd ../accounts
docker build -t localhost:5000/appcket_accounts:v0.0.1 .
docker push localhost:5000/appcket_accounts:v0.0.1
