variable "environment" {
  description = "Environment name"
  type        = string
}

variable "alb_arn" {
  description = "ARN of the internal ALB"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the internal ALB"
  type        = string
}

variable "web_acl_arn" {
  description = "ARN of the CloudFront WAF Web ACL"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1"
  type        = string
}

variable "aliases" {
  description = "CloudFront alternate domain names"
  type        = list(string)
}

variable "geo_restriction_locations" {
  description = "List of ISO country codes for geo restriction"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for WAF resources"
  type        = map(string)
  default     = {}
}