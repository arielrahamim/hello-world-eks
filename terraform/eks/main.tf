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
  create_aws_auth_configmap       = false
  # manage_aws_auth_configmap      = true
  enable_irsa = true

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.micro", "m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    blue = {
      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      min_size       = 1
      max_size       = 15
      desired_size   = 1
    }
  }

  # # Fargate Profile(s)
  # fargate_profiles = {
  #   default = {
  #     name      = "app"
  #     selectors = [{ namespace = "default" }]
  #   }
  # }

  tags = {
    Terraform = "true"
  }
}

# look into a bug that you need to delete lines 110-114 from the json policy
# either install the aws load balancer or supply new json policy for the module
module "kubernetes_addons" {
  source                              = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"
  eks_cluster_id                      = module.eks.cluster_name
  enable_aws_load_balancer_controller = true
}

