module "networking" {
  count              = var.vpc_cluster
  source             = "./networking"
  project_name       = var.project_name
  cidr               = "10.0.${tostring(16 * count.index)}.0/20" # 10.0.0.0/20 -> 10.0.16.0/20
  availability_zones = var.availability_zones
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  region             = var.region
}

module "eks" {
  count                           = var.vpc_cluster
  source                          = "./eks"
  vpc_id                          = module.networking[count.index].vpc_id
  project_name                    = var.project_name
  cluster_addons                  = var.cluster_addons
  subnet_ids                      = module.networking[count.index].private_subnets
  cluster_version                 = var.cluster_version
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
}

module "api-gateway" {
  source             = "./api-gateway"
  alb_listener_arn   = var.alb_listener_arn
  vpc_id             = module.networking[0].vpc_id
  private_subnet_ids = module.networking[0].private_subnets
}


module "nginx-ingress-controller" {
  source = "./nginx-ingress-controller"
  kubeconfig_path = var.kubeconfig_path
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id = module.networking[1].vpc_id
  vpc_id      = module.networking[0].vpc_id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "VPC Peering Between VPC[0] to VPC[1]"
  }
}