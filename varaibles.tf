variable "region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-east-2"  # Adjust as needed
}

variable "strapi_image" {
  type        = string
  description = "Strapi Docker image with tag from ECR (e.g., <account_id>.dkr.ecr.<region>.amazonaws.com/strapi-app:latest)"
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the ECS Task Execution Role used by the task definition"
  default     = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"  # Replace with actual role ARN
}
variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet IDs for ECS tasks"
   default = ["subnet-abc123", "subnet-def456"] # Example values, replace with actual subnet IDs
}

variable "ecs_security_group" {
  type        = string
  description = "Security Group ID for ECS tasks"
}