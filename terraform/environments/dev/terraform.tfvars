
environment = "dev"

vpc_name = "dev-vpc"

vpc_cidr = "10.0.0.0/16"

azs = [
  "eu-west-1a",
  "eu-west-1b"
]

private_subnets = [
  "10.0.10.0/24",
  "10.0.11.0/24",
]

database_subnets = [
  "10.0.20.0/24",
  "10.0.21.0/24"
]

cloudfront_prefix_list_id = "pl-4fa04526"
s3_prefix_list_id         = "pl-6da54004"

db_name = "postgrestore"

db_username = "postgres"

db_instance_class = "db.t3.micro"

allocated_storage = 20

engine_version = "17.11"

major_engine_version = "17"

backup_retention_period = 7

deletion_protection = false

# frontend_image  = "322056173622.dkr.ecr.eu-west-1.amazonaws.com/react-frontend:a5f82de"
# frontend_cpu    = 256
# frontend_memory = 512

# backend_image  = "322056173622.dkr.ecr.eu-west-1.amazonaws.com/node-backend:a5f82de"
# backend_cpu    = 256
# backend_memory = 512
 
frontend_image  = "322056173622.dkr.ecr.eu-west-1.amazonaws.com/dev-frontend:latest"
frontend_cpu    = 256
frontend_memory = 512

backend_image  = "322056173622.dkr.ecr.eu-west-1.amazonaws.com/dev-backend:latest"
backend_cpu    = 256
backend_memory = 512

ecs_frontend_desired_count = 1
ecs_backend_desired_count  = 1


domain_name = "elephantcode.click"

tags = {
  Environment = "dev"
  Project     = "postgrestore"
  ManagedBy   = "Terraform"
}

