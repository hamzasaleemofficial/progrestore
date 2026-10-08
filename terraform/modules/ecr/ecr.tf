module "frontend" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "3.2.0"

  repository_name = "${var.environment}-frontend"

  repository_type = "private"

  repository_image_tag_mutability = "IMMUTABLE"

  repository_image_scan_on_push = true

  create_lifecycle_policy = false

  repository_force_delete = false

  tags = var.tags
}


module "backend" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "3.2.0"

  repository_name = "${var.environment}-backend"

  repository_type = "private"

  repository_image_tag_mutability = "IMMUTABLE"

  repository_image_scan_on_push = true

  create_lifecycle_policy = false

  repository_force_delete = false

  tags = var.tags
}