# Login to IBM Cloud
ibmcloud login
ibmcloud cr login

# Obtain the CR endpoint
ibmcloud cr info

# Define a namespace
ibmcloud cr namespace-add knative

# Create a write token
ibmcloud cr token-add --readwrite --non-expiring --description "ko token"

# Store credentials in ~/.docker/config.json
docker login -u token -p <token> <endpoint>
