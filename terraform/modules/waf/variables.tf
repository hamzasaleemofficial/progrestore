variable "waf_name" {
  description = "Name of the CloudFront WAF Web ACL"
  type        = string
}

variable "rate_limit" {
  description = "Maximum number of requests allowed from a single IP address during the WAF rate evaluation window"
  type        = number
  default     = 1000
}

variable "tags" {
  description = "Tags for WAF resources"
  type        = map(string)
  default     = {}
}