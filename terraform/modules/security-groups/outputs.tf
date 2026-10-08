output "internal_alb_sg_id" {
  description = "Internal ALB security group ID"
  value       = module.internal_alb.id
}

output "frontend_sg_id" {
  description = "Frontend security group ID"
  value       = module.frontend.id
}

output "backend_sg_id" {
  description = "Backend security group ID"
  value       = module.backend.id
}

output "database_sg_id" {
  description = "Database security group ID"
  value       = module.database.id
}

output "vpc_endpoint_sg_id" {
  description = "VPC endpoint security group ID"
  value       = module.vpc_endpoints.id
}