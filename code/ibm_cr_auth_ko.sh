# Login to IBM Cloud
ibmcloud login
ibmcloud cr login

# Obtain the CR endpoint
ibmcloud cr info

# Define a namespace
ibmcloud cr namespace-add knative

# Create a user API key. Read the "apikey" field from "key_file"
ibmcloud iam api-key-create ko-to-cr-key -d "API Key for ko" --file key_file

# Store credentials in ~/.docker/config.json
docker login -u iamapikey -p <apikey> <endpoint>
