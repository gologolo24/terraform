


locals {
  required_tags = {
    Environment  = var.metadata.environment
    Email        = var.metadata.email
    Objective    = var.metadata.objective
    ManagedBy    = "Terraform"
    "Start Date" = var.metadata.start_date
    "Expiration" = var.metadata.end_date
  }
}


locals {
  cluster_name = var.cluster_name
  ebs_csi_role_name = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  oidc_fully_qualified_subjects = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
  ami_type = "AL2_x86_64"
  az_filter_value = "opt-in-not-required"
  ebs_csi_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

locals {
  private_subnets = [for i in range(var.vpc_config.subnet_count) : cidrsubnet(var.vpc_config.cidr, var.vpc_config.subnet_newbits, i)]
  public_subnets  = [for i in range(var.vpc_config.subnet_count) : cidrsubnet(var.vpc_config.cidr, var.vpc_config.subnet_newbits, i + var.vpc_config.subnet_count)]
}