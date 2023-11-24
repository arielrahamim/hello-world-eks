# GLOBAL VARS START
###################

project_name = "hello-world-eks"
region       = ["eu-central-1"]
# GLOBAL VARS END
#################

# GLOBAL NETWORKING START
#########################

cidr               = "172.31.0.0/16"
availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1a"]
private_subnets    = ["172.31.1.0/24", "172.31.2.0/24", "172.31.3.0/24"]
public_subnets     = ["172.31.10.0/24", "172.31.11.0/24", "172.31.12.0/24"]
enable_nat_gateway = true
single_nat_gateway = true
enable_vpn_gateway = false
# GLOBAL NETWORKING END
#########################

# EKS START
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
###################
# EKS END

# ALB START

alb_listener_arn = "arn:aws:elasticloadbalancing:eu-central-1:011528411754:listener/app/k8s-default-hellowor-8cb7faeb77/ddaad0ac6fbad5b4/f69ca9675184e302"
# ALB END

