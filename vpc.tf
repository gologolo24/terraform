module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name               = var.vpc_config.name
  cidr               = var.vpc_config.cidr
  azs                = slice(data.aws_availability_zones.available.names, 0, var.vpc_config.subnet_count)

  private_subnets    = local.private_subnets
  public_subnets     = local.public_subnets

  enable_nat_gateway = var.vpc_config.enable_nat_gateway
  single_nat_gateway = var.vpc_config.single_nat_gateway
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.required_tags
}