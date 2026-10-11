variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "database_subnets" {
  description = "Database subnet CIDR blocks"
  type        = list(string)
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
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}


variable "db_name" {
  description = "Initial PostgreSQL database name"
  type        = string
}

variable "db_username" {
  description = "Master username for PostgreSQL"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
}
variable "major_engine_version" {
  description = "PostgreSQL major engine version"
  type        = string
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
}

variable "deletion_protection" {
  description = "Enable RDS deletion protection"
  type        = bool
}

variable "frontend_image" {
  description = "Frontend ECR image URI"
  type        = string
}

variable "frontend_cpu" {
  description = "Frontend task CPU units"
  type        = number
}

variable "frontend_memory" {
  description = "Frontend task memory in MiB"
  type        = number
}

variable "backend_image" {
  description = "Backend task image URI"
  type        = string
}

variable "backend_cpu" {
  description = "Backend task CPU units"
  type        = number
}

variable "backend_memory" {
  description = "Backend task memory in MiB"
  type        = number
}

variable "domain_name" {
  description = "Application domain name"
  type        = string
}

variable "log_retention_in_days" {
  description = "Number of days to retain ECS application logs"
  type        = number
  default     = 30
}






