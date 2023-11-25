module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "${var.project_name}-vpc"
  cidr               = var.cidr
  azs                = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_vpn_gateway = false


  ### tagging public subnets for load balancer controller
  public_subnet_tags = {
    "kubernetes.io/role/elb"                        = 1
    "kubernetes.io/cluster/${var.project_name}" = "owned"
  }
  ### tagging private subnets for load balancer controller
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"               = 1
    "kubernetes.io/cluster/${var.project_name}" = "owned"
  }

  tags = {
    Terraform = "true"
  }

}