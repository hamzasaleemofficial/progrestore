output "alb_id" {
  description = "Internal ALB ID"
  value       = module.alb.id
}

output "alb_arn" {
  description = "Internal ALB ARN"
  value       = module.alb.arn
}

output "alb_dns_name" {
  description = "Internal ALB DNS name"
  value       = module.alb.dns_name
}

output "frontend_target_group_arn" {
  description = "Frontend target group ARN"
  value       = module.alb.target_groups["frontend"].arn
}

output "backend_target_group_arn" {
  description = "Backend target group ARN"
  value       = module.alb.target_groups["backend"].arn
}

output "frontend_target_group_name" {
  description = "Frontend target group name"
  value       = module.alb.target_groups["frontend"].name
}

output "backend_target_group_name" {
  description = "Backend target group name"
  value       = module.alb.target_groups["backend"].name
}