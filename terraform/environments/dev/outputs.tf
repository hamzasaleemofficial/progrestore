# ============================================================
# VPC OUTPUTS
# ============================================================

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  description = "Database subnet IDs"
  value       = module.vpc.database_subnet_ids
}

output "private_route_table_ids" {
  description = "Private route table IDs"
  value       = module.vpc.private_route_table_ids
}



# ============================================================
# SECURITY GROUP OUTPUTS
# ============================================================

output "internal_alb_sg_id" {
  description = "Internal ALB security group ID"
  value       = module.security_groups.internal_alb_sg_id
}

output "frontend_sg_id" {
  description = "Frontend security group ID"
  value       = module.security_groups.frontend_sg_id
}

output "backend_sg_id" {
  description = "Backend security group ID"
  value       = module.security_groups.backend_sg_id
}

output "database_sg_id" {
  description = "Database security group ID"
  value       = module.security_groups.database_sg_id
}

output "vpc_endpoint_sg_id" {
  description = "VPC endpoint security group ID"
  value       = module.security_groups.vpc_endpoint_sg_id
}

# ============================================================
# SVPC ENDPOINT OUTPUTS
# ============================================================

output "vpc_endpoint_ids" {
  description = "VPC endpoint IDs"
  value       = module.vpc_endpoints.vpc_endpoint_ids
}

# ============================================================
# SECR OUTPUTS
# ============================================================

output "frontend_ecr_repository_name" {
  description = "Frontend ECR repository name"
  value       = module.ecr.frontend_repository_name
}

output "frontend_ecr_repository_url" {
  description = "Frontend ECR repository URL"
  value       = module.ecr.frontend_repository_url
}

output "frontend_ecr_repository_arn" {
  description = "Frontend ECR repository ARN"
  value       = module.ecr.frontend_repository_arn
}


output "backend_ecr_repository_name" {
  description = "Backend ECR repository name"
  value       = module.ecr.backend_repository_name
}

output "backend_ecr_repository_url" {
  description = "Backend ECR repository URL"
  value       = module.ecr.backend_repository_url
}

output "backend_ecr_repository_arn" {
  description = "Backend ECR repository ARN"
  value       = module.ecr.backend_repository_arn
}

# ============================================================
# RDS OUTPUTS
# ============================================================

output "rds_instance_id" {
  description = "RDS instance identifier"
  value       = module.rds.db_instance_id
}

output "rds_instance_arn" {
  description = "RDS instance ARN"
  value       = module.rds.db_instance_arn
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_address" {
  description = "RDS database hostname"
  value       = module.rds.db_instance_address
}

output "rds_port" {
  description = "RDS database port"
  value       = module.rds.db_instance_port
}

output "rds_master_user_secret_arn" {
  description = "RDS master user secret ARN"
  value       = module.rds.master_user_secret_arn
}

# ============================================================
# Target Groups + ALB OUTPUTS
# ============================================================

output "alb_id" {
  description = "Internal ALB ID"
  value       = module.alb.alb_id
}

output "alb_arn" {
  description = "Internal ALB ARN"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "Internal ALB DNS name"
  value       = module.alb.alb_dns_name
}

output "frontend_target_group_arn" {
  description = "Frontend target group ARN"
  value       = module.alb.frontend_target_group_arn
}

output "backend_target_group_arn" {
  description = "Backend target group ARN"
  value       = module.alb.backend_target_group_arn
}

output "frontend_target_group_name" {
  description = "Frontend target group name"
  value       = module.alb.frontend_target_group_name
}

output "backend_target_group_name" {
  description = "Backend target group name"
  value       = module.alb.backend_target_group_name
}

# ============================================================
# ECS OUTPUTS
# ============================================================


output "ecs_cluster_id" {
  description = "ECS cluster ID"
  value       = module.ecs.cluster_id
}

output "ecs_cluster_arn" {
  description = "ECS cluster ARN"
  value       = module.ecs.cluster_arn
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "frontend_task_definition_arn" {
  description = "Frontend ECS task definition ARN"
  value       = module.ecs.frontend_task_definition_arn
}

output "backend_task_definition_arn" {
  description = "Backend ECS task definition ARN"
  value       = module.ecs.backend_task_definition_arn
}

variable "ecs_frontend_desired_count" {
  description = "Desired count of frontend ECS tasks"
  type        = number
}

variable "ecs_backend_desired_count" {
  description = "Desired count of backend ECS tasks"
  type        = number
}

output "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = module.route53.zone_id
}

output "route53_name_servers" {
  description = "Route 53 name servers"
  value       = module.route53.name_servers
}

output "route53_zone_name" {
  description = "Route 53 hosted zone name"
  value       = module.route53.zone_name
}

output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.acm.certificate_arn
}

output "certificate_domain_name" {
  description = "Primary domain name of the ACM certificate"
  value       = module.acm.certificate_domain_name
}

output "certificate_status" {
  description = "Status of the ACM certificate"
  value       = module.acm.certificate_status
}


output "waf_web_acl_id" {
  description = "CloudFront WAF Web ACL ID"
  value       = module.waf.web_acl_id
}

output "waf_web_acl_arn" {
  description = "CloudFront WAF Web ACL ARN"
  value       = module.waf.web_acl_arn
}

output "waf_web_acl_name" {
  description = "CloudFront WAF Web ACL name"
  value       = module.waf.web_acl_name
}