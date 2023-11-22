terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.0"
    }
  }
}


provider "aws" {
  region = var.region[0] # var.region = list containig only one string (eu-central-1)
}


module "networking" {
  source             = "./networking"
  environment        = var.environment
  project_name       = var.project_name
  cidr               = var.cidr
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  region             = var.region
}

module "eks" {
  source         = "./eks"
  vpc_id         = module.networking.vpc_id
  cluster_addons = var.cluster_addons
}