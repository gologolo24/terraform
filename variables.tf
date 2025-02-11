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

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

variable "email" {
  description = "Email of the Owner of the resources"
  type        = string
  default     = "lejb.golovatyi@develeap.com"
}

variable "objective" {
  description = "Name of the project"
  type        = string
  default     = "Portfolio-2.0-Leib"
}



variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.29"
}

variable "start_date" {
  description = "Project start date in DD/MM/YYYY format"
  type        = string
  default     = "21/01/2025"
  
  validation {
    condition     = can(regex("^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}$", var.start_date))
    error_message = "Start date must be in DD/MM/YYYY format"
  }
}

variable "end_date" {
  description = "Project end date in DD/MM/YYYY format"
  type        = string
  default     = "22/01/2025"
  
  validation {
    condition     = can(regex("^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}$", var.end_date))
    error_message = "End date must be in DD/MM/YYYY format"
  }
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

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}

