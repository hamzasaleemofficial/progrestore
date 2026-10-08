variable "environment" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Tags applied to the Terraform state bucket"
  type        = map(string)
}