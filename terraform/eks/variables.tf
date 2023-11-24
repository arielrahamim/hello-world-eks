
# EKS
variable "project_name" {
  type        = string
  description = "project name"
  default     = "dev"
}


variable "vpc_id" {
  type        = string
  description = ""
}

variable "cluster_addons" {
  description = "Configuration for cluster addons"
  type = map(object({
    most_recent = bool
  }))
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs where the nodes/node groups will be provisioned."
}

# variable "control_plane_subnet_ids" {
#   type        = list(string)
#   description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
# }

variable "cluster_version" {
  type        = string
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.27`)"
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
}
variable "cluster_endpoint_private_access" {
  type        = bool
  description = "value"
}


