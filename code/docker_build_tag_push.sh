#!/bin/bash

# Define variables
TAG=$(git log -1 --pretty=%H)
REGISTRY=de.icr.io/knative

# Build and push the image
docker build .
docker tag ${REGISTRY}/go_helloworld:${TAG}
docker push ${REGISTRY}/go_helloworld:${TAG}
