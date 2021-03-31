#!/bin/bash
#

ENV=development

while getopts e: option
do
case "${option}"
in
e) ENV=${OPTARG};;
esac
done

echo '--------------------------'
echo "|Deploying for $ENV|"
echo '--------------------------'

# if production env, apply the correct ambassador manifest
if [ $ENV = 'production' ]; then
  # REFACTOR: dynamically get VM's public ip address
  publicIp="206.189.214.201"
  # replace string in ambassador-service.yaml with vm public ip address
  sed -i "s/__replaceWithPublicIp__/$publicIp/g" "./environment/$ENV/resource-manifests/ambassador-service.yaml"

  kubectl apply -f ./environment/$ENV/resource-manifests/ambassador-no-rbac.yaml
else
  kubectl apply -f ./environment/$ENV/resource-manifests/ambassador-rbac.yaml
fi

kubectl apply -f ./environment/$ENV/resource-manifests/ambassador-service.yaml

# REFACTOR: instead of sleep, add a poller that checks when ambassador is up and running
sleep 20

# get ambassador cluster ip address
loadBalancerClusterIp="$(kubectl get svc ambassador -o jsonpath='{.spec.clusterIP}')"

if [[ -v loadBalancerClusterIp ]]; then
  # replace string in api.yaml with real load balancer ip address
  sed -i "s/__replaceWithLoadBalancerClusterIp__/$loadBalancerClusterIp/g" "./environment/$ENV/resource-manifests/api.yaml"

  kubectl apply -f ./environment/$ENV/resource-manifests/accounts.yaml -f ./environment/$ENV/resource-manifests/api.yaml

  # set the ip address back to a replacebale string for next time
  sed -i "s/$loadBalancerClusterIp/__replaceWithLoadBalancerClusterIp__/g" "./environment/$ENV/resource-manifests/api.yaml"
else
  echo "Load Balancer Cluster IP not found. Deployment unable to proceed."
  exit
fi

if [ $ENV = 'production' ]; then
  # set the ip address back to a replacebale string for next time
  sed -i "s/$publicIp/__replaceWithPublicIp__/g" "./environment/$ENV/resource-manifests/ambassador-service.yaml"

# if production env, also deploy app container
  kubectl apply -f ./environment/$ENV/resource-manifests/app.yaml
fi
