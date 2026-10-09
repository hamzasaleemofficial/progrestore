module "terraform_policy" {

  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.1.1"

  name        = var.policy_name
  description = "Terraform infrastructure permissions to manage ${var.environment} core infrastructure."

  policy = templatefile(
    "${path.module}/policies/terraform-dev.json",
    {
      ecr_repository_arns = jsonencode(var.ecr_repository_arns)

      rds_instance_arns        = jsonencode(var.rds_instance_arns)
      rds_subnet_group_arns    = jsonencode(var.rds_subnet_group_arns)
      rds_parameter_group_arns = jsonencode(var.rds_parameter_group_arns)

      load_balancer_arns = jsonencode(var.load_balancer_arns)
      target_group_arns  = jsonencode(var.target_group_arns)

      ecs_cluster_arns = jsonencode(var.ecs_cluster_arns)
      ecs_service_arns = jsonencode(var.ecs_service_arns)

      iam_pass_role_arns = jsonencode(var.iam_pass_role_arns)
      iam_role_arns      = jsonencode(var.iam_role_arns)

      terraform_state_bucket_arn = var.terraform_state_bucket_arn

      tags = jsonencode(var.tags)
    }
  )

  tags = var.tags
}


module "terraform_services_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.1.1"

  name        = var.services_policy_name
  description = "Terraform permissions to manage ${var.environment} AWS service integrations."

  policy = templatefile(
    "${path.module}/policies/terraform-services-dev.json",
    {
      iam_pass_role_arns = jsonencode(var.iam_pass_role_arns)
      iam_role_arns      = jsonencode(var.iam_role_arns)

      cloudfront_distribution_arns = jsonencode(var.cloudfront_distribution_arns)
      cloudfront_cache_policy_arns = jsonencode(var.cloudfront_cache_policy_arns)
      waf_web_acl_arns             = jsonencode(var.waf_web_acl_arns)
      route53_zone_arns            = jsonencode(var.route53_zone_arns)
      acm_certificate_arns         = jsonencode(var.acm_certificate_arns)
      secret_arns                  = jsonencode(var.secret_arns)
      log_group_arns               = jsonencode(var.log_group_arns)
    }
  )

  tags = var.tags
}