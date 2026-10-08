output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.acm.acm_certificate_arn
}

output "certificate_domain_name" {
  description = "Primary domain name of the ACM certificate"
  value       = module.acm.distinct_domain_names
}

output "certificate_status" {
  description = "Status of the ACM certificate"
  value       = module.acm.acm_certificate_status
}