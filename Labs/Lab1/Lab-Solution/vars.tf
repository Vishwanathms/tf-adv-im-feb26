variable "environment" {
  type        = string
  description = "Environment name (dev/staging/prod) supplied by Jenkins from workspace"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "subnet_id" {
  type        = string
  description = "The VPC Subnet ID to launch the EC2 instance in"
}