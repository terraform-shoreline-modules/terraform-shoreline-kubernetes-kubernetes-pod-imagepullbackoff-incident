resource "shoreline_notebook" "kubernetes_pod_imagepullbackoff_incident" {
  name       = "kubernetes_pod_imagepullbackoff_incident"
  data       = file("${path.module}/data/kubernetes_pod_imagepullbackoff_incident.json")
  depends_on = [shoreline_action.invoke_restart_pod_or_deployment]
}

resource "shoreline_file" "restart_pod_or_deployment" {
  name             = "restart_pod_or_deployment"
  input_file       = "${path.module}/data/restart_pod_or_deployment.sh"
  md5              = filemd5("${path.module}/data/restart_pod_or_deployment.sh")
  description      = "Restart the pod or the entire Kubernetes deployment to attempt to pull the image again."
  destination_path = "/agent/scripts/restart_pod_or_deployment.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_restart_pod_or_deployment" {
  name        = "invoke_restart_pod_or_deployment"
  description = "Restart the pod or the entire Kubernetes deployment to attempt to pull the image again."
  command     = "`chmod +x /agent/scripts/restart_pod_or_deployment.sh && /agent/scripts/restart_pod_or_deployment.sh`"
  params      = ["DEPLOYMENT_NAME","POD_NAME"]
  file_deps   = ["restart_pod_or_deployment"]
  enabled     = true
  depends_on  = [shoreline_file.restart_pod_or_deployment]
}

