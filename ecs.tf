resource "aws_ecs_cluster" "strapi_cluster" {
  name = "strapi-cluster"
}

resource "aws_cloudwatch_log_group" "ecs_strapi_LG" {
  name              = "/ecs/strapi"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "strapi_TD" {
  family                   = "strapi-task"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  container_definitions    = jsonencode([{
    name      = "strapi"
    image     = "var.strapi_image"
    essential = true
    portMappings = [{
      containerPort = 1337
      hostPort      = 1337
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.ecs_strapi_LG.name
        awslogs-region        = "var.region"
        awslogs-stream-prefix = "strapi"
      }
    }
  }])
}

resource "aws_ecs_service" "ecs_strapi_service" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.strapi_cluster.id
  task_definition = aws_ecs_task_definition.strapi_TD.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.ecs_security_group]
    assign_public_ip = false
  }

  depends_on = [aws_ecs_task_definition.strapi_TD]
}