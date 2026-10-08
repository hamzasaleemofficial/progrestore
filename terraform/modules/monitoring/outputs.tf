output "frontend_log_group_name" {
  description = "CloudWatch log group name for the frontend ECS service"
  value       = module.frontend_logs.cloudwatch_log_group_name
}

output "frontend_log_group_arn" {
  description = "CloudWatch log group ARN for the frontend ECS service"
  value       = module.frontend_logs.cloudwatch_log_group_arn
}

output "backend_log_group_name" {
  description = "CloudWatch log group name for the backend ECS service"
  value       = module.backend_logs.cloudwatch_log_group_name
}

output "backend_log_group_arn" {
  description = "CloudWatch log group ARN for the backend ECS service"
  value       = module.backend_logs.cloudwatch_log_group_arn
}