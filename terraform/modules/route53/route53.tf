module "route53" {
  source  = "terraform-aws-modules/route53/aws"
  version = "6.5.1"

  create_zone = true

  name = var.domain_name

  comment = "Route 53 hosted zone for ${var.domain_name}"

  tags = var.tags
}