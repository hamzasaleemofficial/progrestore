output "zone_id" {
  description = "Route 53 hosted zone ID"
  value       = module.route53.id
}

output "name_servers" {
  description = "Route 53 name servers"
  value       = module.route53.name_servers
}

output "zone_name" {
  description = "Route 53 hosted zone name"
  value       = module.route53.name
}

output "zone_arn" {
  description = "Route 53 hosted zone ARN"
  value       = "arn:aws:route53:::hostedzone/${module.route53.id}"
}