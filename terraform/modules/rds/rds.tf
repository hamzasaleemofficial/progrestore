module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 7.2.2"

  identifier = "${var.environment}-postgres"

  # PostgreSQL
  engine               = "postgres"
  engine_version       = var.engine_version
  major_engine_version = var.major_engine_version
  family               = "postgres${var.major_engine_version}"

  create_db_option_group = false
  # Database
  db_name  = var.db_name
  username = var.db_username
  port     = 5432

  # Instance
  instance_class    = var.db_instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp3"

  # Network
  create_db_subnet_group = true
  subnet_ids             = var.database_subnet_ids

  vpc_security_group_ids = [
    var.database_sg_id
  ]

  # Encryption
  storage_encrypted = true

  # Password managed by AWS Secrets Manager
  manage_master_user_password = true

  # Backups
  backup_retention_period = var.backup_retention_period
  copy_tags_to_snapshot   = true

  # Protection
  deletion_protection = var.deletion_protection
  skip_final_snapshot = false

  # Maintenance
  auto_minor_version_upgrade = true

  tags = var.tags
}