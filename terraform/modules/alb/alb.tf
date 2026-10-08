module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.1"

  name = "${var.environment}-internal-alb"

  load_balancer_type = "application"
  internal           = true

  vpc_id  = var.vpc_id
  subnets = var.private_subnet_ids

  security_groups = [
    var.internal_alb_sg_id
  ]

  enable_deletion_protection = false

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "frontend"
      }

      rules = {
        backend = {
          priority = 10

          actions = [
            {
              forward = {
                target_group_key = "backend"
              }
            }
          ]

          conditions = [
            {
              path_pattern = {
                values = ["/api/*"]
              }
            }
          ]
        }
      }
    }
  }

  target_groups = {
    frontend = {
      name_prefix = "fe-"

      protocol    = "HTTP"
      port        = 5173
      target_type = "ip"

      create_attachment = false

      health_check = {
        enabled             = true
        protocol            = "HTTP"
        port                = "traffic-port"
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 30
        matcher             = "200"
      }
    }

    backend = {
      name_prefix = "be-"

      protocol    = "HTTP"
      port        = 5000
      target_type = "ip"

      create_attachment = false

      health_check = {
        enabled             = true
        protocol            = "HTTP"
        port                = "traffic-port"
        path                = "/health"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 30
        matcher             = "200"
      }
    }
  }

  tags = var.tags
}