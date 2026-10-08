module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "7.6.1"

  cluster_name = "${var.environment}-ecs-cluster"

  cluster_configuration = {
    name  = "containerInsights"
    value = "enabled"
  }

  services = {
    frontend = {
      name = "${var.environment}-frontend"

      cpu    = var.frontend_cpu
      memory = var.frontend_memory

      launch_type = "FARGATE"

      create_service = true

      enable_autoscaling = false

      subnet_ids = var.private_subnet_ids

      create_security_group = false

      security_group_ids = [
        var.frontend_sg_id
      ]

      create_task_definition = true

      desired_count = var.ecs_frontend_desired_count

      load_balancer = {
        service = {
          target_group_arn = var.frontend_target_group_arn
          container_name   = "frontend"
          container_port   = 5173
        }
      }

      container_definitions = {
        frontend = {
          name      = "frontend"
          image     = var.frontend_image
          essential = true

          enable_cloudwatch_logging   = true
          create_cloudwatch_log_group = false
          cloudwatch_log_group_name   = var.frontend_log_group_name

          logConfiguration = {
            logDriver = "awslogs"

            options = {
              awslogs-region        = "eu-west-1"
              awslogs-group         = var.frontend_log_group_name
              awslogs-stream-prefix = "ecs"
            }
          }

          portMappings = [
            {
              name          = "frontend"
              containerPort = 5173
              hostPort      = 5173
              protocol      = "tcp"
            }
          ]
        }
      }
    }

    backend = {
      name = "${var.environment}-backend"

      cpu    = var.backend_cpu
      memory = var.backend_memory

      launch_type = "FARGATE"

      create_service = true

      enable_autoscaling = false

      subnet_ids = var.private_subnet_ids

      create_security_group = false

      security_group_ids = [
        var.backend_sg_id
      ]

      create_task_definition = true

      desired_count = var.ecs_backend_desired_count

      task_exec_secret_arns = [
        var.application_db_secret_arn
      ]

      load_balancer = {
        service = {
          target_group_arn = var.backend_target_group_arn
          container_name   = "backend"
          container_port   = 5000
        }
      }

      container_definitions = {
        backend = {
          name      = "backend"
          image     = var.backend_image
          essential = true

          enable_cloudwatch_logging   = true
          create_cloudwatch_log_group = false
          cloudwatch_log_group_name   = var.backend_log_group_name

          logConfiguration = {
            logDriver = "awslogs"

            options = {
              awslogs-region        = "eu-west-1"
              awslogs-group         = var.backend_log_group_name
              awslogs-stream-prefix = "ecs"
            }
          }

          portMappings = [
            {
              name          = "backend"
              containerPort = 5000
              hostPort      = 5000
              protocol      = "tcp"
            }
          ]

          environment = [
            {
              name  = "PG_HOST"
              value = var.database_host
            },
            {
              name  = "PG_DATABASE"
              value = var.database_name
            },
            {
              name  = "PG_USER"
              value = "app_user"
            },
            {
              name  = "PG_PORT"
              value = tostring(var.database_port)
            }
          ]

          secrets = [
            {
              name      = "PG_PASSWORD"
              valueFrom = var.application_db_secret_arn
            }
          ]
        }
      }
    }
  }

  tags = var.tags
}

data "aws_ecs_task_definition" "frontend" {
  task_definition = module.ecs.services["frontend"].task_definition_arn
}

data "aws_ecs_task_definition" "backend" {
  task_definition = module.ecs.services["backend"].task_definition_arn
}

