variable "domain_name" {
  description = "Primary domain name for the ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID used for ACM DNS validation"
  type        = string
}

variable "tags" {
  description = "Tags for ACM resources"
  type        = map(string)
  default     = {}
}