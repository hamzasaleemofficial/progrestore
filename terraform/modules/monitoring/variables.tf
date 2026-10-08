variable "environment" {
  description = "Environment name"
  type        = string
}

variable "log_retention_in_days" {
  description = "Number of days to retain ECS application logs"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}