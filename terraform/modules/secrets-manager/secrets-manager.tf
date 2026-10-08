module "application_db_secret" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "2.2.0"

  name        = "${var.environment}/database/application"
  description = "Application database password for ${var.environment}"

  create_random_password = true
  random_password_length = 32

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-application-db-secret"
    }
  )
}