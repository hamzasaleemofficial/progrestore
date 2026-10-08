output "web_acl_id" {
  description = "WAF Web ACL ID"
  value       = module.waf.web_acl_id
}

output "web_acl_arn" {
  description = "WAF Web ACL ARN"
  value       = module.waf.web_acl_arn
}

output "web_acl_name" {
  description = "WAF Web ACL name"
  value       = module.waf.web_acl_name
}