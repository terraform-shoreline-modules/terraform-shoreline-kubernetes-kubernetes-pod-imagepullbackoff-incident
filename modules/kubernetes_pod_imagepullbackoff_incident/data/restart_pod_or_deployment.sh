#!/bin/bash

# Replace ${POD_NAME} and ${DEPLOYMENT_NAME} with the actual names of the pod and deployment

pod_name=${POD_NAME}

deployment_name=${DEPLOYMENT_NAME}

# Restart the pod by deleting and recreating it

kubectl delete pod $pod_name

kubectl get pod $pod_name -w

# Alternatively, restart the entire deployment

kubectl rollout restart deployment $deployment_name

kubectl get deployment $deployment_name -w