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

####### API GATEWAY #######
resource "aws_security_group" "api_gateway_sg" {
  name        = "api_gateway_sg"
  description = "Security group for API Gateway"
  vpc_id      = module.networking.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an HTTP VPC Link
resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = "api-gw-vpc-link"
  subnet_ids         = module.networking.private_subnets
  security_group_ids = [aws_security_group.api_gateway_sg.id]
}

# Create the API Gateway (HTTP API)
resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "my-api-gateway"
  protocol_type = "HTTP"
}

# Create a Stage for API Deployment
resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "$default"
  auto_deploy = true
}

# Define API Gateway Integration
resource "aws_apigatewayv2_integration" "integration" {
  api_id             = aws_apigatewayv2_api.api_gateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = var.alb_listener_arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.vpc_link.id
}

# Define Routes
resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.integration.id}"
}