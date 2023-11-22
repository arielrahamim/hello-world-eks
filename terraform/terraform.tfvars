################
# GLOBAL VARS START

project_name = "chess-app"
environment  = "dev"

region = ["eu-central-1"]

#################
# GLOBAL VARS END



#################
# GLOBAL NETWORKING START

cidr               = "172.31.0.0/16"
availability_zones = ["eu-central-1a", "eu-central-1b"]
private_subnets    = ["172.31.1.0/24", "172.31.2.0/24"]
public_subnets     = ["172.31.10.0/24", "172.31.11.0/24"]
enable_nat_gateway = true
enable_vpn_gateway = false

#################
# GLOBAL NETWORKING START



# EKS

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

