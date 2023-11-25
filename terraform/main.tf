terraform {
  cloud {
    organization = "arielrahamim"
    workspaces {
      name = "hello-world-eks"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
}

provider "aws" {
  region = var.region[0] # var.region = list containig only one string (eu-central-1)
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", "${var.project_name}"]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", "${var.project_name}"]
    }
  }
}

module "networking" {
  source             = "./networking"
  project_name       = var.project_name
  cidr               = var.cidr
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  region             = var.region
}

module "eks" {
  source                          = "./eks"
  vpc_id                          = module.networking.vpc_id
  project_name                    = var.project_name
  cluster_addons                  = var.cluster_addons
  subnet_ids                      = module.networking.private_subnets
  cluster_version                 = var.cluster_version
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
}

module "api-gateway" {
  source             = "./api-gateway"
  alb_listener_arn   = var.alb_listener_arn
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnets
}