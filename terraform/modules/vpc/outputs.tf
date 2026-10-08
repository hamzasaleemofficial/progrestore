output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnets
  description = "Private Subnet IDs"
}

output "database_subnet_ids" {
  description = "Database subnet IDs"
  value       = module.vpc.database_subnets
}

output "private_route_table_ids" {
  value       = module.vpc.private_route_table_ids
  description = "Private Route Table IDs"
}

output "internet_gateway_id" {
  value       = module.vpc.igw_id
  description = "Internet Gateway ID"
}

