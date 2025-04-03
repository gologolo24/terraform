data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}


data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = [local.az_filter_value]
  }
}

data "aws_iam_policy" "ebs_csi_policy" {
  arn  = local.ebs_csi_policy_arn
  tags = local.required_tags
}




