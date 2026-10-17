output "policy_arn" {

  description = "ARN of the Terraform infrastructure IAM policy."

  value = module.terraform_policy.arn
}


output "services_policy_arn" {

  description = "ARN of the Terraform services IAM policy."

  value = module.terraform_services_policy.arn
}

output "network_policy_arn" {
  description = "ARN of the Terraform network IAM policy."
  value       = module.terraform_network_policy.arn
}