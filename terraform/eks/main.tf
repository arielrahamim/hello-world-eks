module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                    = var.project_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_addons                  = var.cluster_addons
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  enable_irsa                     = true

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.micro", "m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    blue = {
      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      min_size       = 1
      max_size       = 5
      desired_size   = 1
    }
  }

  # aws_auth_users = [
  #   {
  #     userarn  = "arn:aws:iam::011528411754:user/Mushrambo" 
  #     username = "Mushrambo"
  #     groups   = ["system:masters"]
  #   },
  # ]
  # aws_auth_accounts = ["011528411754"]

  tags = {
    Terraform = "true"
  }
}