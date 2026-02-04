provider "aws" {
  region = var.region
}

locals {
  name_prefix = var.environment
}

module "ec2" {
  source    = "./modules/ec2"
  name      = "${local.name_prefix}-ec2"
  subnet_id = var.subnet_id

  tags = {
    Environment = local.name_prefix
    ManagedBy   = "Terraform"
  }
}

output "workspace" {
  value = terraform.workspace
}

output "instance_id" {
  value = module.ec2.instance_id
}
