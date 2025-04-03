module "irsa_argocd" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.2.0"

  create_role           = true
  role_name             = var.argocd_role_name
  provider_url          = module.eks.oidc_provider
  role_policy_arns      = var.argocd_role_policy_arns

  oidc_fully_qualified_subjects = var.argocd_oidc_subjects
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = { 
    aws-ebs-csi-driver = {
      service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = var.ami_type

  }

  eks_managed_node_groups = var.node_groups


  tags = local.required_tags
}


