variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "environment" {
  description = "Environment name such as dev, stag, or prod"
  type        = string
}

variable "cloudfront_prefix_list_id" {
  description = "CloudFront origin-facing managed prefix list ID"
  type        = string
}

variable "s3_prefix_list_id" {
  description = "S3 managed prefix list ID"
  type        = string
}

variable "tags" {
  description = "Common tags applied to security groups"
  type        = map(string)
  default     = {}
}