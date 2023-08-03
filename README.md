
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kubernetes Pod ImagePullBackOff Incident
---

A Kubernetes Pod ImagePullBackOff incident occurs when a pod in a Kubernetes cluster is unable to pull its container image. This can happen due to various reasons, such as incorrect image path or tag, or misconfigured image pulling credentials. This incident can cause the pod to fail to start and impact the availability of the application running in the pod. It requires investigation and resolution to ensure the pod can pull its container image and restart successfully.

### Parameters
```shell
# Environment Variables

export NAMESPACE="PLACEHOLDER"

export POD_NAME="PLACEHOLDER"

export CONTAINER_NAME="PLACEHOLDER"

export IMAGE_TAG="PLACEHOLDER"

export IMAGE_NAME="PLACEHOLDER"

export DEPLOYMENT_NAME="PLACEHOLDER"
```

## Debug

### Check the status of the pod
```shell
kubectl describe pod ${POD_NAME} -n ${NAMESPACE}
```

### Check the events related to the pod
```shell
kubectl get events -n ${NAMESPACE} --sort-by=.metadata.creationTimestamp | grep ${POD_NAME}
```

### Check the credentials used for pulling the container image
```shell
kubectl get secrets -n ${NAMESPACE}
```

### Check the image path and tag specified in the pod configuration
```shell
kubectl describe pod ${POD_NAME} -n ${NAMESPACE} | grep image:
```

## Repair

### Restart the pod or the entire Kubernetes deployment to attempt to pull the image again.
```shell
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


```