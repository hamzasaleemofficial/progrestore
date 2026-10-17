output "task_definition_arn" {
  description = "Database initializer ECS task definition ARN."
  value       = aws_ecs_task_definition.this.arn
}

output "task_definition_family" {
  description = "Database initializer ECS task definition family."
  value       = aws_ecs_task_definition.this.family
}

output "execution_role_arn" {
  description = "Database initializer ECS task execution role ARN."
  value       = aws_iam_role.execution.arn
}
