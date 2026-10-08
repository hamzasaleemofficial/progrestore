module "frontend_logs" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "5.7.2"

  name              = "/aws/ecs/${var.environment}-frontend/frontend"
  retention_in_days = var.log_retention_in_days

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-frontend-log-group"
    }
  )
}

module "backend_logs" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "5.7.2"

  name              = "/aws/ecs/${var.environment}-backend/backend"
  retention_in_days = var.log_retention_in_days

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-backend-log-group"
    }
  )
}