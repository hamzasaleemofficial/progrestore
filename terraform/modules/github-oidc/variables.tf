variable "environment" {
  description = "Environment name."
  type        = string
}

variable "terraform_policy_arns" {

  description = "ARNs of the Terraform infrastructure IAM policies."

  type = list(string)
}

variable "tags" {
  description = "Tags applied to GitHub OIDC resources."
  type        = map(string)
  default     = {}
}