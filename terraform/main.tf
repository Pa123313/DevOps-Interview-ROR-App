provider "aws" {
  region = "eu-north-1"  # Change to your AWS region
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ror-cluster"
}

resource "aws_ecs_task_definition" "ror_task" {
  family                   = "ror-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "ror-app"
      image     = "717279725185.dkr.ecr.eu-north-1.amazonaws.com/my-ror-app:latest"
      cpu       = 256
      memory    = 512
      essential = true
provider "aws" {
  region = "eu-north-1"  # Change to your AWS region
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ror-cluster"
}

resource "aws_ecs_task_definition" "ror_task" {
  family                   = "ror-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "ror-app"
      image     = "717279725185.dkr.ecr.eu-north-1.amazonaws.com/my-ror-app:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}
