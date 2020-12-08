#!/bin/bash
# create user and its role to access the default namespace
kubectl apply -f sa.yml

# get account token name
TOKEN_NAME=$(kubectl get serviceaccount svcs-acct-dply -o jsonpath='{.secrets[].name}')

# get token value decrypted
USER_TOKEN=$(kubectl get secret "$TOKEN_NAME" --template={{.data.token}} | base64 -d)

# get cluster certificate-authority-data
CLUSTER_CERT=$(kubectl config view --flatten --minify -o jsonpath='{.clusters[].cluster.certificate-authority-data}')

# get server url
CLUSTER_SERVER_URL=$(kubectl config view --flatten --minify -o jsonpath='{.clusters[].cluster.server}')
# DOCKER_PORT=$(docker container inspect minikube | jq -r '.[0].NetworkSettings.Ports."8443/tcp" [0].HostPort')
# CLUSTER_SERVER_URL="https://localhost:${DOCKER_PORT}"

cat kubeconfig.template.json | sed "s|{{USER_TOKEN}}|$USER_TOKEN|" | sed "s|{{CLUSTER_CERT}}|$CLUSTER_CERT|" | sed "s|{{CLUSTER_SERVER_URL}}|$CLUSTER_SERVER_URL|" > kubeconfig.json
