region           = "ap-south-1"
cluster_name     = "Portfolio-2-Leib"
metadata = {
  environment = "test"
  email       = "lejb.golovatyi@develeap.com"
  objective   = "Portfolio-2.0-Leib"
  start_date  = "21/01/2025"
  end_date    = "22/01/2025"
}

cluster_version  = "1.30"

vpc_config = {
  name               = "leib-vpc"
  cidr               = "10.0.0.0/16"
  subnet_count       = 3
  subnet_newbits     = 8
  enable_nat_gateway = true
  single_nat_gateway = true
}

ami_type = "AL2_x86_64"

node_groups = {
  one = {
    name           = "node-group-1"
    instance_types = ["t3a.medium"]
    min_size       = 1
    max_size       = 3
    desired_size   = 2
  }
  two = {
    name           = "node-group-2"
    instance_types = ["t3a.medium"]
    min_size       = 1
    max_size       = 2
    desired_size   = 1
  }
}

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c"
]

argocd_role_name = "argocd-eks-access"

argocd_role_policy_arns = [
  "arn:aws:iam::aws:policy/AdministratorAccess"
]

argocd_oidc_subjects = [
  "system:serviceaccount:argocd:argocd-application-controller"
]

helm_chart_config = {
  argocd = {
    namespace = "argocd"
    version   = "7.8.2"
  }

  nginx_ingress = {
    namespace = "ingress-nginx"
    version   = "4.11.3"
  }

  prometheus = {
    namespace = "monitoring"
    version   = "58.3.0"
  }

  cert_manager = {
    namespace = "cert-manager"
    version   = "v1.5.1"
  }

   rancher = {
    namespace = "cattle-system"
    version   = "2.10.3" # Update as per Rancher release
  }
}