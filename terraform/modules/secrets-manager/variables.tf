variable "environment" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the secret"
  type        = map(string)
  default     = {}
}