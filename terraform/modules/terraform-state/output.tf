output "bucket_name" {
  description = "Terraform remote state S3 bucket name"

  value = module.terraform_state.s3_bucket_id
}

output "bucket_arn" {
  description = "Terraform remote state S3 bucket ARN"

  value = module.terraform_state.s3_bucket_arn
}