terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region     = var.region
  access_key = var.credentials.access_key
  secret_key = var.credentials.secret_key
}


resource "aws_key_pair" "user_login" {
  key_name   = "${var.name}-user-login"
  public_key = var.public_key
}

resource "aws_instance" "server" {
  ami           = var.spec.containers.image.image
  instance_type = "t2.micro"
  key_name      = aws_key_pair.user_login.key_name
  tags = {
    Name = var.name
  }
}
