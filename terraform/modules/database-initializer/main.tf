data "aws_partition" "current" {}

resource "aws_iam_role" "execution" {
  name = "${var.environment}-database-initializer-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = merge(var.tags, {
    Name = "${var.environment}-database-initializer-execution-role"
  })
}

resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "secrets" {
  name = "${var.environment}-database-initializer-secrets"
  role = aws_iam_role.execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue"
      ]
      Resource = [
        var.master_user_secret_arn,
        var.application_db_secret_arn
      ]
    }]
  })
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.environment}-database-initializer"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.cpu)
  memory                   = tostring(var.memory)
  execution_role_arn       = aws_iam_role.execution.arn

  container_definitions = jsonencode([
    {
      name      = "database-initializer"
      image     = var.backend_image
      essential = true

      command = ["node", "scripts/init-db-user.js"]

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
          name  = "PG_PORT"
          value = tostring(var.database_port)
        },
        {
          name  = "APP_PG_USER"
          value = var.application_db_user
        }
      ]

      secrets = [
        {
          name      = "MASTER_PG_USER"
          valueFrom = "${var.master_user_secret_arn}:username::"
        },
        {
          name      = "MASTER_PG_PASSWORD"
          valueFrom = "${var.master_user_secret_arn}:password::"
        },
        {
          name      = "APP_PG_PASSWORD"
          valueFrom = var.application_db_secret_arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.aws_region
          awslogs-group         = var.log_group_name
          awslogs-stream-prefix = "database-initializer"
        }
      }
    }
  ])

  tags = merge(var.tags, {
    Name = "${var.environment}-database-initializer"
  })

  depends_on = [
    aws_iam_role_policy_attachment.execution,
    aws_iam_role_policy.secrets
  ]
}
