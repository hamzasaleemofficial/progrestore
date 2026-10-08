variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS will be created"
  type        = string
}

variable "database_subnet_ids" {
  description = "Private database subnet IDs for RDS"
  type        = list(string)
}

variable "database_sg_id" {
  description = "Security group ID for RDS"
  type        = string
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

variable "rds_parameter_group_arns" {
  description = "ARNs of RDS DB parameter groups managed by Terraform."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}