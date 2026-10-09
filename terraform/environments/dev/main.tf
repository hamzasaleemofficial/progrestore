module "vpc" {
  source = "../../modules/vpc"

  vpc_name         = var.vpc_name
  vpc_cidr         = var.vpc_cidr
  azs              = var.azs
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets

  tags = var.tags
}

module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id                    = module.vpc.vpc_id
  cloudfront_prefix_list_id = var.cloudfront_prefix_list_id
  s3_prefix_list_id         = var.s3_prefix_list_id

  environment = var.environment

  tags = var.tags
}

module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  route_table_ids = module.vpc.private_route_table_ids

  vpc_endpoint_sg_id = module.security_groups.vpc_endpoint_sg_id

  environment = var.environment

  tags = var.tags
}

module "ecr" {
  source = "../../modules/ecr"

  environment = var.environment

  tags = var.tags
}


module "rds" {

  source = "../../modules/rds"

  environment = var.environment

  vpc_id = module.vpc.vpc_id

  database_subnet_ids = module.vpc.database_subnet_ids

  database_sg_id = module.security_groups.database_sg_id

  db_name = var.db_name

  db_username = var.db_username

  db_instance_class = var.db_instance_class

  allocated_storage = var.allocated_storage

  engine_version = var.engine_version

  major_engine_version = var.major_engine_version

  backup_retention_period = var.backup_retention_period

  deletion_protection = var.deletion_protection

  tags = var.tags
}

module "alb" {
  source = "../../modules/alb"

  environment = var.environment

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  internal_alb_sg_id = module.security_groups.internal_alb_sg_id

  tags = var.tags
}


module "ecs" {
  source = "../../modules/ecs"

  environment = var.environment

  frontend_image  = var.frontend_image
  frontend_cpu    = var.frontend_cpu
  frontend_memory = var.frontend_memory

  ecs_frontend_desired_count = var.ecs_frontend_desired_count
  ecs_backend_desired_count  = var.ecs_backend_desired_count

  frontend_log_group_name = module.monitoring.frontend_log_group_name
  backend_log_group_name  = module.monitoring.backend_log_group_name

  backend_image  = var.backend_image
  backend_cpu    = var.backend_cpu
  backend_memory = var.backend_memory

  private_subnet_ids = module.vpc.private_subnet_ids

  frontend_sg_id = module.security_groups.frontend_sg_id
  backend_sg_id  = module.security_groups.backend_sg_id

  frontend_target_group_arn = module.alb.frontend_target_group_arn
  backend_target_group_arn  = module.alb.backend_target_group_arn

  database_host = module.rds.db_instance_address
  database_name = var.db_name
  database_port = module.rds.db_instance_port

  application_db_secret_arn = module.secrets_manager.application_db_secret_arn

  tags = var.tags
}

module "route53" {

  environment = var.environment

  source = "../../modules/route53"

  domain_name = var.domain_name

  tags = var.tags
}

module "acm" {
  source = "../../modules/acm"

  providers = {
    aws = aws.us_east_1
  }

  domain_name     = var.domain_name
  route53_zone_id = module.route53.zone_id

  tags = var.tags
}

module "waf" {
  source = "../../modules/waf"

  providers = {
    aws = aws.us_east_1
  }

  waf_name   = "${var.environment}-cloudfront-waf"
  rate_limit = 1000

  tags = var.tags
}


module "cloudfront" {
  source = "../../modules/cloudfront"

  environment = var.environment

  alb_arn      = module.alb.alb_arn
  alb_dns_name = module.alb.alb_dns_name

  web_acl_arn = module.waf.web_acl_arn

  acm_certificate_arn = module.acm.certificate_arn

  aliases = [
    var.domain_name
  ]
}

data "aws_ecs_service" "frontend" {
  cluster_arn  = module.ecs.cluster_arn
  service_name = module.ecs.frontend_service_name
}

data "aws_ecs_service" "backend" {
  cluster_arn  = module.ecs.cluster_arn
  service_name = module.ecs.backend_service_name
}

data "aws_caller_identity" "current" {}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

module "iam" {
  source = "../../modules/iam"

  environment = var.environment

  policy_name          = "Terraform-Infrastructure-Dev"
  services_policy_name = "Terraform-Services-Dev"

  terraform_state_bucket_arn = module.terraform_state.bucket_arn

  ecr_repository_arns = [
    module.ecr.frontend_repository_arn,
    module.ecr.backend_repository_arn
  ]

  rds_instance_arns = [
    module.rds.db_instance_arn
  ]

  load_balancer_arns = [
    module.alb.alb_arn
  ]

  target_group_arns = [
    module.alb.frontend_target_group_arn,
    module.alb.backend_target_group_arn
  ]

  rds_parameter_group_arns = [
    module.rds.db_parameter_group_arn
  ]

  iam_pass_role_arns = [
    module.ecs.frontend_task_execution_role_arn,
    module.ecs.frontend_task_role_arn,
    module.ecs.backend_task_execution_role_arn,
    module.ecs.backend_task_role_arn
  ]

  iam_role_arns = [
    module.ecs.frontend_task_execution_role_arn,
    module.ecs.frontend_task_role_arn,
    module.ecs.backend_task_execution_role_arn,
    module.ecs.backend_task_role_arn
  ]


  secret_arns = [
    module.secrets_manager.application_db_secret_arn
  ]

  cloudfront_distribution_arns = [
    module.cloudfront.distribution_arn
  ]

  cloudfront_cache_policy_arns = [
    data.aws_cloudfront_cache_policy.caching_disabled.arn,
    data.aws_cloudfront_cache_policy.caching_optimized.arn
  ]

  waf_web_acl_arns = [
    module.waf.web_acl_arn
  ]

  route53_zone_arns = [
    module.route53.zone_arn
  ]

  acm_certificate_arns = [
    module.acm.certificate_arn
  ]

  rds_subnet_group_arns = [
    module.rds.db_subnet_group_arn
  ]

  ecs_cluster_arns = [
    module.ecs.cluster_arn
  ]

  ecs_service_arns = [
    data.aws_ecs_service.frontend.arn,
    data.aws_ecs_service.backend.arn
  ]

  log_group_arns = [
    module.monitoring.frontend_log_group_arn,
    module.monitoring.backend_log_group_arn
  ]

  tags = var.tags
}

module "github_oidc" {
  source = "../../modules/github-oidc"

  environment = "dev"

  iam_policy_arns = {
    infrastructure = module.iam.policy_arn
    services       = module.iam.services_policy_arn
  }

  tags = var.tags
}


module "secrets_manager" {
  source = "../../modules/secrets-manager"

  environment = var.environment

  tags = var.tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  environment           = var.environment
  log_retention_in_days = var.log_retention_in_days
  tags                  = var.tags
}

module "terraform_state" {
  source = "../../modules/terraform-state"

  environment = var.environment
  tags        = var.tags
}