output "application_db_secret_arn" {
  description = "ARN of the application database password secret"
  value       = module.application_db_secret.secret_arn
}

output "application_db_secret_name" {
  description = "Name of the application database password secret"
  value       = module.application_db_secret.secret_name
}