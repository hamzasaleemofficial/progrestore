output "oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  value       = module.github_oidc.arn
}

output "role_arn" {
  description = "ARN of the GitHub Actions IAM role."
  value       = module.github_actions_role.arn
}

output "role_name" {
  description = "Name of the GitHub Actions IAM role."
  value       = module.github_actions_role.name
}