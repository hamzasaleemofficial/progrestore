variable "environment" {
  description = "Deployment environment name, such as dev, stag, or prod."
  type        = string
}

variable "backend_image" {
  description = "Backend container image containing scripts/init-db-user.js."
  type        = string
}

variable "database_host" {
  description = "RDS PostgreSQL hostname."
  type        = string
}

variable "database_name" {
  description = "Application database name."
  type        = string
}

variable "database_port" {
  description = "RDS PostgreSQL port."
  type        = number
  default     = 5432
}

variable "master_user_secret_arn" {
  description = "ARN of the RDS-managed master credentials secret."
  type        = string
}

variable "application_db_secret_arn" {
  description = "ARN of the application database password secret."
  type        = string
}

variable "application_db_user" {
  description = "PostgreSQL role used by the application."
  type        = string
  default     = "app_user"
}

variable "log_group_name" {
  description = "Existing CloudWatch log group for backend task logs."
  type        = string
}

variable "aws_region" {
  description = "AWS region used for CloudWatch logging."
  type        = string
  default     = "eu-west-1"
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 512
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
  default     = {}
}
