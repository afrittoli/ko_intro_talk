#!/bin/bash

# Login and env
ibmcloud login
ibmcloud cr login
export DOCKER_TOKEN=$(ibmcloud cr token-get 5e83b578-aa80-5e85-8932-94b453da64ef -q)
docker login -u token -p $DOCKER_TOKEN registry.eu-gb.bluemix.net
eval $(ibmcloud ks cluster-config andreaf_knative --export)
export KO_DOCKER_REPO=registry.eu-gb.bluemix.net/knative

# Build, push and deploy
ko apply -f config

# Verify
kubectl get all
PUBLIC_IP=$(kubectl get service/helloworld-service -o jsonpath="{.status.loadBalancer.ingress[*].ip}")
curl -v $PUBLIC_IP:8080/${RECIPIENT:-"World"}| jq .

# Update the code
cp script/helloworld_ms.go.modified helloworld_ms.go
git diff
git add -u
git commit -m "No slashes in the response"

# Build, push and deploy
ko apply -f config

# Verify
export RECIPIENT=Kubecon
curl -v $PUBLIC_IP:8080/${RECIPIENT:-"World"}| jq .

# Cleanup
ko delete -f config/
