# ============================================================
# INTERNAL ALB SECURITY GROUP
# ============================================================

module "internal_alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "${var.environment}-internal-alb-sg"
  description = "Security group for internal ALB"
  vpc_id      = var.vpc_id

  ingress_rules = {
    cloudfront = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"

      prefix_list_id = var.cloudfront_prefix_list_id

      description = "CloudFront origin-facing to ALB"
    }
  }

  egress_rules = {
    frontend = {
      from_port   = 5173
      to_port     = 5173
      ip_protocol = "tcp"

      referenced_security_group_id = module.frontend.id

      description = "ALB to frontend ECS"
    }

    backend = {
      from_port   = 5000
      to_port     = 5000
      ip_protocol = "tcp"

      referenced_security_group_id = module.backend.id

      description = "ALB to backend ECS"
    }
  }

  tags = var.tags
}


# ============================================================
# FRONTEND SECURITY GROUP
# ============================================================

module "frontend" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "${var.environment}-frontend-sg"
  description = "Security group for frontend ECS"
  vpc_id      = var.vpc_id

  ingress_rules = {
    alb = {
      from_port   = 5173
      to_port     = 5173
      ip_protocol = "tcp"

      referenced_security_group_id = module.internal_alb.id

      description = "Internal ALB to frontend"
    }
  }

  egress_rules = {
    backend = {
      from_port   = 5000
      to_port     = 5000
      ip_protocol = "tcp"

      referenced_security_group_id = module.backend.id

      description = "Frontend to backend ECS"
    }

    vpc_endpoints = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"

      referenced_security_group_id = module.vpc_endpoints.id

      description = "Frontend to VPC endpoints"
    }

    s3 = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"

      prefix_list_id = var.s3_prefix_list_id

      description = "Frontend to S3"
    }
  }

  tags = var.tags
}


# ============================================================
# BACKEND SECURITY GROUP
# ============================================================

module "backend" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "${var.environment}-backend-sg"
  description = "Security group for backend ECS"
  vpc_id      = var.vpc_id

  ingress_rules = {
    alb = {
      from_port   = 5000
      to_port     = 5000
      ip_protocol = "tcp"

      referenced_security_group_id = module.internal_alb.id

      description = "Internal ALB to backend"
    }
  }

  egress_rules = {
    database = {
      from_port   = 5432
      to_port     = 5432
      ip_protocol = "tcp"

      referenced_security_group_id = module.database.id

      description = "Backend to PostgreSQL"
    }

    vpc_endpoints = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"

      referenced_security_group_id = module.vpc_endpoints.id

      description = "Backend to VPC endpoints"
    }

    s3 = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"

      prefix_list_id = var.s3_prefix_list_id

      description = "Backend to S3"
    }
  }

  tags = var.tags
}


# ============================================================
# DATABASE SECURITY GROUP
# ============================================================

module "database" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "${var.environment}-database-sg"
  description = "Security group for PostgreSQL database"
  vpc_id      = var.vpc_id

  ingress_rules = {
    postgres = {
      from_port   = 5432
      to_port     = 5432
      ip_protocol = "tcp"

      referenced_security_group_id = module.backend.id

      description = "Backend ECS to PostgreSQL"
    }
  }

  tags = var.tags
}


# ============================================================
# VPC ENDPOINT SECURITY GROUP
# ============================================================

module "vpc_endpoints" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "${var.environment}-vpc-endpoint-sg"
  description = "Security group for VPC interface endpoints"
  vpc_id      = var.vpc_id

  ingress_rules = {
    frontend = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"

      referenced_security_group_id = module.frontend.id

      description = "Frontend ECS to VPC endpoints"
    }

    backend = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"

      referenced_security_group_id = module.backend.id

      description = "Backend ECS to VPC endpoints"
    }
  }

  egress_rules = {
    frontend = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"

      referenced_security_group_id = module.frontend.id

      description = "VPC endpoints to frontend ECS"
    }

    backend = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"

      referenced_security_group_id = module.backend.id

      description = "VPC endpoints to backend ECS"
    }
  }

  tags = var.tags
}