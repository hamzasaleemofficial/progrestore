
variable "environment" {

  description = "Environment name."

  type = string

}

variable "policy_name" {

  description = "Name of the Terraform infrastructure IAM policy."

  type = string

}


# ECR

variable "ecr_repository_arns" {

  description = "ARNs of ECR repositories managed by Terraform."

  type = list(string)

  default = []

}


# RDS

variable "rds_instance_arns" {

  description = "ARNs of RDS DB instances managed by Terraform."

  type = list(string)

  default = []

}

variable "rds_subnet_group_arns" {

  description = "ARNs of RDS DB subnet groups managed by Terraform."

  type = list(string)

  default = []

}


# Application Load Balancer

variable "load_balancer_arns" {

  description = "ARNs of Application Load Balancers managed by Terraform."

  type = list(string)

  default = []

}

variable "target_group_arns" {

  description = "ARNs of ALB target groups managed by Terraform."

  type = list(string)

  default = []

}


# ECS

variable "ecs_cluster_arns" {

  description = "ARNs of ECS clusters managed by Terraform."

  type = list(string)

  default = []

}

variable "ecs_service_arns" {

  description = "ARNs of ECS services managed by Terraform."

  type = list(string)

  default = []

}


# IAM

variable "iam_pass_role_arns" {

  description = "IAM role ARNs that ECS resources may pass."

  type = list(string)

  default = []

}

variable "iam_role_arns" {

  description = "IAM role ARNs managed by Terraform."

  type = list(string)

  default = []

}


# CloudFront

variable "cloudfront_distribution_arns" {

  description = "ARNs of CloudFront distributions managed by Terraform."

  type = list(string)

  default = []

}


# WAF

variable "waf_web_acl_arns" {

  description = "ARNs of WAF Web ACLs managed by Terraform."

  type = list(string)

  default = []

}


# Route 53

variable "route53_zone_arns" {

  description = "ARNs of Route 53 hosted zones managed by Terraform."

  type = list(string)

  default = []

}


# ACM

variable "acm_certificate_arns" {

  description = "ARNs of ACM certificates managed by Terraform."

  type = list(string)

  default = []

}


# Secrets Manager

variable "secret_arns" {

  description = "ARNs of Secrets Manager secrets managed by Terraform."

  type = list(string)

  default = []

}


# CloudWatch Logs

variable "log_group_arns" {

  description = "ARNs of CloudWatch log groups managed by Terraform."

  type = list(string)

  default = []

}

variable "rds_parameter_group_arns" {
  description = "ARNs of RDS DB parameter groups managed by Terraform"
  type        = list(string)
}

variable "services_policy_name" {

  description = "Name of the Terraform services IAM policy."

  type = string
}

# Terraform Remote State

variable "terraform_state_bucket_arn" {

  description = "ARN of the S3 bucket used for Terraform remote state."

  type = string

}

variable "iam_policy_arns" {
  description = "ARNs of IAM policies managed by Terraform."
  type        = list(string)
  default     = []
}

# Tags

variable "tags" {

  description = "Tags applied to IAM resources."

  type = map(string)

  default = {}

}

