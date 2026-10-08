output "frontend_repository_name" {
  description = "Frontend ECR repository name"
  value       = module.frontend.repository_name
}

output "frontend_repository_url" {
  description = "Frontend ECR repository URL"
  value       = module.frontend.repository_url
}

output "frontend_repository_arn" {
  description = "Frontend ECR repository ARN"
  value       = module.frontend.repository_arn
}


output "backend_repository_name" {
  description = "Backend ECR repository name"
  value       = module.backend.repository_name
}

output "backend_repository_url" {
  description = "Backend ECR repository URL"
  value       = module.backend.repository_url
}

output "backend_repository_arn" {
  description = "Backend ECR repository ARN"
  value       = module.backend.repository_arn
}