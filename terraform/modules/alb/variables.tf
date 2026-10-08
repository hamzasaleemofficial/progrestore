variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private application subnet IDs for the internal ALB"
  type        = list(string)
}

variable "internal_alb_sg_id" {
  description = "Security group ID for the internal ALB"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}