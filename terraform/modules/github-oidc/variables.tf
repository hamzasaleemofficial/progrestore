variable "environment" {
  description = "Environment name."
  type        = string
}


variable "iam_policy_arns" {
  description = "IAM policy ARNs to attach to the GitHub Actions Terraform role."
  type        = map(string)
}

variable "tags" {
  description = "Tags applied to GitHub OIDC resources."
  type        = map(string)
  default     = {}
}