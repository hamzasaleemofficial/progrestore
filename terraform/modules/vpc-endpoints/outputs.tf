output "vpc_endpoint_ids" {
  description = "VPC endpoint IDs"
  value       = module.vpc_endpoints.endpoints
}