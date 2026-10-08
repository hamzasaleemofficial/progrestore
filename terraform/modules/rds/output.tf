output "db_instance_id" {
  description = "RDS instance identifier"
  value       = module.rds.db_instance_identifier
}

output "db_instance_arn" {
  description = "RDS instance ARN"
  value       = module.rds.db_instance_arn
}

output "db_instance_address" {
  description = "RDS database hostname"
  value       = module.rds.db_instance_address
}

output "db_instance_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_port" {
  description = "RDS database port"
  value       = module.rds.db_instance_port
}


output "master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the RDS master credentials"
  value       = module.rds.db_instance_master_user_secret_arn
}


output "db_subnet_group_arn" {
  description = "RDS DB subnet group ARN"
  value       = module.rds.db_subnet_group_arn
}

output "db_parameter_group_arn" {
  description = "RDS DB parameter group ARN"
  value       = module.rds.db_parameter_group_arn
}