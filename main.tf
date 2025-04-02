# Create IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

# Attach ECS Task Execution Policy to the IAM Role
resource "aws_iam_policy" "ecs_task_execution_policy" {
  name        = "ecs-task-execution-policy"
  description = "Policy to allow ECS tasks to pull images and write logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ecs:UpdateContainerInstancesState",
          "ecs:SubmitAttachmentStateChanges",
          "ecs:SubmitTaskStateChanges"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Attach the ECS task execution policy to the ECS task execution role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}
