# GLOBAL VARS START
###################

project_name = "eks-cluster"
region       = ["eu-central-1"]
# GLOBAL VARS END
#################

# GLOBAL NETWORKING START
#########################
vpc_cluster        = 2
availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1a"]
# private_subnets    = 
# public_subnets     = ["10.0.32.0/20"]
enable_nat_gateway = true
single_nat_gateway = true
enable_vpn_gateway = false
# GLOBAL NETWORKING END
#########################

# EKS START
##########################
cluster_addons = {
  kube-proxy = {
    most_recent = true
  }
  vpc-cni = {
    most_recent = true
  }
  coredns = {
    most_recent = true
  }
}
cluster_version                 = "1.28"
cluster_endpoint_private_access = true
cluster_endpoint_public_access  = true
########################
# EKS END

# ALB START
###################
alb_listener_arn = "arn:aws:elasticloadbalancing:eu-central-1:011528411754:listener/app/k8s-default-hellowor-8cb7faeb77/45f87b45d9dc6502/c12c1646e9838464"

# ALB END
##################




# nginx-ingress-controller start

kubeconfig_path = "/home/mushrambo/.kube/config"

# end
