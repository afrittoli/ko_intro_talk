#!/bin/bash

ibm_eu_login
ibmcloud cr login
export DOCKER_TOKEN=$(ibmcloud cr token-get 5e83b578-aa80-5e85-8932-94b453da64ef -q)
docker login -u token -p $DOCKER_TOKEN registry.eu-gb.bluemix.net
eval $(ibmcloud ks cluster-config andreaf_knative --export)
export KO_DOCKER_REPO=registry.eu-gb.bluemix.net/knative
ko apply -f config
kubectl get all
PUBLIC_IP=$(kubectl get service/helloworld-service -o jsonpath="{.status.loadBalancer.ingress[*].ip}")
curl -v $PUBLIC_IP:8080/${RECIPIENT:-"World"}| jq .
