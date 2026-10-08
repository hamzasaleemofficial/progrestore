module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs              = var.azs
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets

  create_igw           = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false


  tags = var.tags

}

resource "aws_internet_gateway" "this" {
  vpc_id = module.vpc.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-igw"
    }
  )
}