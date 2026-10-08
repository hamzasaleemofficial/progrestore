output "cluster_id" {
  description = "ECS cluster ID"
  value       = module.ecs.cluster_id
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = module.ecs.cluster_arn
}

output "cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "frontend_task_definition_arn" {
  description = "Frontend ECS task definition ARN"
  value       = module.ecs.services["frontend"].task_definition_arn
}

output "frontend_service_name" {
  description = "Frontend ECS service name"
  value       = module.ecs.services["frontend"].name
}

output "backend_task_definition_arn" {
  description = "Backend ECS task definition ARN"
  value       = module.ecs.services["backend"].task_definition_arn
}

output "backend_service_name" {
  description = "Backend ECS service name"
  value       = module.ecs.services["backend"].name
}

output "frontend_task_execution_role_arn" {
  description = "Frontend ECS task execution role ARN"
  value       = module.ecs.services["frontend"].task_exec_iam_role_arn
}


output "backend_task_execution_role_arn" {
  description = "Backend ECS task execution role ARN"
  value       = module.ecs.services["backend"].task_exec_iam_role_arn
}



output "frontend_task_role_arn" {
  description = "Frontend ECS task role ARN"
  value       = data.aws_ecs_task_definition.frontend.task_role_arn
}

output "backend_task_role_arn" {
  description = "Backend ECS task role ARN"
  value       = data.aws_ecs_task_definition.backend.task_role_arn
}



