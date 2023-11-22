################
# GLOBAL VARS START
variable "region" {
  type        = list(string)
  description = "region"
}

variable "project_name" {
  type        = string
  description = "project name"
  default     = "chess-app"
}

variable "environment" {
  type        = string
  description = "value"
}


# GLOBAL VARS END
#################


#######################
# NETWORKING VARS START

variable "cidr" {
  type        = string
  description = "cidr for vpc"
}

variable "availability_zones" {
  type        = list(string)
  description = "azs"
}

variable "private_subnets" {
  type        = list(string)
  description = ""
}

variable "public_subnets" {
  type        = list(string)
  description = "value"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "create nat_gateway yes/no"
}

variable "enable_vpn_gateway" {
  type        = bool
  description = "create vpn_gateway yes/no"
}
# NETWORKING VARS END
#####################
