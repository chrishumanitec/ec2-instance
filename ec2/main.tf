terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.0"
}

locals {
  # The container object from the workload
  container     = var.spec.containers[keys(var.spec.containers)[0]]
  ami_id        = local.container.image

  # Overrides that can be supplied by Developers
  public_key    = try(var.spec.annotations["public-key"], var.public_key)
  instance_type = try(var.spec.annotations["instance-type"], var.instance_type)
  tags          = merge(try(var.spec.labels, {}), var.tags)
}

provider "aws" {
  region     = var.region
  access_key = var.credentials.access_key
  secret_key = var.credentials.secret_key
}

resource "aws_key_pair" "user_login" {
  key_name   = "${var.name}-user-login"
  public_key = local.public_key
}

resource "aws_instance" "server" {
  ami           = local.ami_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.user_login.key_name
  user_data     = local.cloud_config_config
  subnet_id     = var.subnet_id
  tags = merge(local.tags, {
    Name = var.name
  })
}
