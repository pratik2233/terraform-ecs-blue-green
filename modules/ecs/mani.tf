########################################
# ECS Cluster
########################################
resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-ecs-cluster"
}

########################################
# ECS Task Definition (Fargate)
########################################
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.environment}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  # ✅ Execution role passed from root (no IAM read)
  execution_role_arn = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "app"
      image = var.container_image

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.environment}"
          awslogs-region        = "us-west-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

########################################
# ECS Service — BLUE
########################################
resource "aws_ecs_service" "blue" {
  name            = "${var.environment}-blue"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = false
  }

  # ✅ load_balancer block ONLY valid here
  load_balancer {
    target_group_arn = var.blue_tg_arn
    container_name   = "app"
    container_port   = var.container_port
  }
}

########################################
# ECS Service — GREEN
########################################
resource "aws_ecs_service" "green" {
  name            = "${var.environment}-green"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = false
  }

  # ✅ load_balancer block ONLY valid here
  load_balancer {
    target_group_arn = var.green_tg_arn
    container_name   = "app"
    container_port   = var.container_port
  }
}
