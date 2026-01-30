variable "app_name" {
  default = "nexus-app"
}

variable "db_password" {
  description = "The password for the RDS PostgreSQL instance"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-2"
}
