module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id = var.vpc_id

  endpoints = {

    # --------------------------------------------------------
    # ECR API
    # --------------------------------------------------------

    ecr_api = {
      service             = "ecr.api"
      service_type        = "Interface"
      subnet_ids          = var.private_subnet_ids
      security_group_ids  = [var.vpc_endpoint_sg_id]
      private_dns_enabled = true

      tags = {
        Name = "${var.environment}-ecr-api-endpoint"
      }
    }

    # --------------------------------------------------------
    # ECR Docker
    # --------------------------------------------------------

    ecr_dkr = {
      service             = "ecr.dkr"
      service_type        = "Interface"
      subnet_ids          = var.private_subnet_ids
      security_group_ids  = [var.vpc_endpoint_sg_id]
      private_dns_enabled = true

      tags = {
        Name = "${var.environment}-ecr-dkr-endpoint"
      }
    }

    # --------------------------------------------------------
    # CloudWatch Logs
    # --------------------------------------------------------

    logs = {
      service             = "logs"
      service_type        = "Interface"
      subnet_ids          = var.private_subnet_ids
      security_group_ids  = [var.vpc_endpoint_sg_id]
      private_dns_enabled = true

      tags = {
        Name = "${var.environment}-cloudwatch-logs-endpoint"
      }
    }

    # --------------------------------------------------------
    # ECS
    # --------------------------------------------------------

    ecs = {
      service             = "ecs"
      service_type        = "Interface"
      subnet_ids          = var.private_subnet_ids
      security_group_ids  = [var.vpc_endpoint_sg_id]
      private_dns_enabled = true

      tags = {
        Name = "${var.environment}-ecs-endpoint"
      }
    }

    # --------------------------------------------------------
    # Secrets Manager
    # --------------------------------------------------------

    secretsmanager = {
      service             = "secretsmanager"
      service_type        = "Interface"
      subnet_ids          = var.private_subnet_ids
      security_group_ids  = [var.vpc_endpoint_sg_id]
      private_dns_enabled = true

      tags = {
        Name = "${var.environment}-secretsmanager-endpoint"
      }
    }

    # --------------------------------------------------------
    # S3
    # --------------------------------------------------------

    s3 = {
      service      = "s3"
      service_type = "Gateway"

      route_table_ids = var.route_table_ids

      tags = {
        Name = "${var.environment}-s3-endpoint"
      }
    }
  }

  tags = var.tags
}