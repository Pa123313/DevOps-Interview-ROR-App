resource "aws_ecs_cluster" "main" {
  name = "ror-app-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "ror-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([{
    name      = "ror-app"
    image     = "${aws_ecr_repository.app.repository_url}:latest"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
    environment = [
      { name = "DATABASE_URL", value = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.main.endpoint}/${var.db_name}" },
      { name = "RAILS_ENV", value = "production" },
      { name = "S3_BUCKET_NAME", value = aws_s3_bucket.app.bucket }
    ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = "/ecs/ror-app",
        "awslogs-region"        = var.region,
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "main" {
  name            = "ror-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    subnets         = aws_subnet.private[*].id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "ror-app"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.front_end]
}
