#!/usr/bin/env bash
set -o pipefail


if ! helm version &> /dev/null; then
  echo "Helm is not installed , please install to proceed"
  exit 1
fi


minikube stop
minikube delete
minikube start --addons=ingress  --install-addons=true --driver=docker --insecure-registry="registry.k8s.io"


helm delete album-app --namespace webserver

function build_and_load() {
    docker build --no-cache -t  "$1" "$2"
    minikube image load "$1"
}
build_and_load web_server/redis:7.2 components/redis
build_and_load web_server/server:1.1 components/server

helm install  album-app infra/album-app --namespace webserver --create-namespace --atomic
LOCAL_IP_ADDRESS=$(minikube ip)
echo "To test the deployment run =>"
echo "wget -O - --no-check-certificate  https://$LOCAL_IP_ADDRESS/api/v1/music-albums?key=25"
echo "Run some load => "
echo "watch -n 0.1 wget -O - --no-check-certificate  https://$LOCAL_IP_ADDRESS/api/v1/music-albums?key=100"
