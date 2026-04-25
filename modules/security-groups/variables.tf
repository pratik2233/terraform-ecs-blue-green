variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "environment" {
  type = string
}

variable "app_port" {
  description = "Application port for ECS"
  type        = number
  default     = 8080
}
