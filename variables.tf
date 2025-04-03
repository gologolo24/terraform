variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "Portfolio-2.0-Leib"
}

variable "metadata" {
  description = "Generic metadata tags"
  type        = map(string)

  default = {}

  validation {
    condition     = can(regex("^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}$", var.metadata.start_date))
    error_message = "Start date must be in DD/MM/YYYY format"
  }

  validation {
    condition     = can(regex("^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}$", var.metadata.end_date))
    error_message = "End date must be in DD/MM/YYYY format"
  }
}

variable "vpc_config" {
  description = "VPC configuration settings"
  type = object({
    name               = string
    cidr               = string
    subnet_count       = number
    subnet_newbits     = number
    enable_nat_gateway = bool
    single_nat_gateway = bool
  })

  default = {
    name               = "leib-vpc"
    cidr               = "10.0.0.0/16"
    subnet_count       = 3
    subnet_newbits     = 8
    enable_nat_gateway = true
    single_nat_gateway = true
  }
}
variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.30"
}



variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

# variable "private_subnet_cidrs" {
#   description = "CIDR blocks for private subnets"
#   type        = list(string)
#   default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }

# variable "public_subnet_cidrs" {
#   description = "CIDR blocks for public subnets"
#   type        = list(string)
#   default     = ["10.0.4.0/24", "10.0.5.0/24"]
# }

variable "ami_type" {
  description = "ami type "
  type        = string
  default     = "AL2_x86_64"
}

variable "node_groups" {
  description = "Configuration for EKS managed node groups"
  type = map(object({
    name           = string
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
  }))
  default = {}
}

variable "argocd_role_name" {
  description = "IAM role name for ArgoCD"
  type        = string
  default     = "argocd-eks-access"
}

variable "argocd_role_policy_arns" {
  description = "IAM policies to attach to ArgoCD IRSA"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

variable "argocd_oidc_subjects" {
  description = "OIDC fully qualified subjects for ArgoCD"
  type        = list(string)
  default     = ["system:serviceaccount:argocd:argocd-application-controller"]
}


variable "helm_chart_config" {
  description = "Namespaces and versions for Helm releases"
  type = map(object({
    namespace = string
    version   = string
  }))
  
  default = {}
}

