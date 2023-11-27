resource "null_resource" "Helm-upgrade" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "bash helm-upgrade.sh"
    environment = {
      KUBECONFIG   = var.kubeconfig_path
      RELEASE_NAME = "nginx-ingress-controller"
      VALUES_FILE  = ""
      NAMESPACE    = "ingress-nginx"
    }
  }
}

