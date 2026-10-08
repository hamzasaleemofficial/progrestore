variable "environment" {
  description = "Environment name"
  type        = string
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

variable "private_subnet_ids" {
  description = "Private application subnet IDs for ECS tasks"
  type        = list(string)
}

variable "frontend_sg_id" {
  description = "Frontend ECS security group ID"
  type        = string
}

variable "backend_image" {
  description = "Backend container image URI"
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

variable "backend_sg_id" {
  description = "Backend ECS security group ID"
  type        = string
}

variable "database_host" {
  description = "RDS PostgreSQL hostname"
  type        = string
}

variable "database_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "database_port" {
  description = "PostgreSQL port"
  type        = number
}

variable "application_db_secret_arn" {
  description = "ARN of the application database credentials secret"
  type        = string
}

variable "frontend_target_group_arn" {
  description = "Frontend ALB target group ARN"
  type        = string
}

variable "backend_target_group_arn" {
  description = "Backend ALB target group ARN"
  type        = string
}

variable "ecs_frontend_desired_count" {
  description = "Desired count of frontend ECS tasks"
  type        = number
}

variable "ecs_backend_desired_count" {
  description = "Desired count of backend ECS tasks"
  type        = number
}

variable "frontend_log_group_name" {
  description = "Frontend ECS CloudWatch log group name"
  type        = string
}

variable "backend_log_group_name" {
  description = "Backend ECS CloudWatch log group name"
  type        = string
}
variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}