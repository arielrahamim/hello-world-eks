locals {
  azs = flatten([for region in var.region : ["${region}a", "${region}b"]])
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "${var.environment}-${var.project_name}-vpc"
  cidr               = var.cidr
  azs                = local.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}