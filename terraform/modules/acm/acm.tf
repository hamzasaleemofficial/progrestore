module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "6.2.0"

  providers = {
    aws = aws.us_east_1
  }

  domain_name = var.domain_name

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  validation_method = "DNS"

  zone_id = var.route53_zone_id

  wait_for_validation = true

  tags = var.tags
}