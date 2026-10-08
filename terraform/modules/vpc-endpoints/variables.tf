variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for interface VPC endpoints"
  type        = list(string)
}

variable "route_table_ids" {
  description = "Route table IDs for the S3 gateway endpoint"
  type        = list(string)
}

variable "vpc_endpoint_sg_id" {
  description = "Security group ID for interface VPC endpoints"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}