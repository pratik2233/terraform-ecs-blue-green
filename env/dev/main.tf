########################################
# VPC
########################################
module "vpc" {
  source = "../../modules/vpc"

  environment = "dev"
  vpc_cidr    = "10.0.0.0/16"

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  azs = ["us-west-1a", "us-west-1c"]
}

########################################
# Security Groups
########################################
module "security_groups" {
  source = "../../modules/security-groups"

  environment = "dev"
  vpc_id      = module.vpc.vpc_id
  app_port    = 8080
}

########################################
# Application Load Balancer (HTTP only)
# Blue/Green target groups
########################################
module "alb" {
  source = "../../modules/alb"

  environment       = "dev"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  alb_sg_id         = module.security_groups.alb_sg_id
  app_port          = 8080
}

########################################
# ECS (Blue / Green Services)
########################################
module "ecs" {
  source = "../../modules/ecs"

  environment        = "dev"
  private_subnet_ids = module.vpc.private_subnets
  ecs_sg_id          = module.security_groups.ecs_sg_id

  blue_tg_arn  = module.alb.blue_tg_arn
  green_tg_arn = module.alb.green_tg_arn

  # Pre-created execution role (no IAM read needed)
  execution_role_arn = "arn:aws:iam::581049838800:role/ecsTaskExecutionRole"

  container_image = "nginx:latest"
  container_port  = 8080
}
