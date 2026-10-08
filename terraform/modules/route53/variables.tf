variable "environment" {
  description = "Environment name"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the hosted zone"
  type        = string
}

variable "tags" {
  description = "Tags for Route 53 resources"
  type        = map(string)
  default     = {}
}