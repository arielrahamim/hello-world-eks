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