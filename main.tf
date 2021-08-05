# Configure the AWS Provider

provider "aws" {
  profile = "jz_netology"
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  private_ip = "10.0.0.100"
  subnet_id  = aws_subnet.netology_jz.id
  
  tags = {
    Name = "Netology_test"
  }
}

resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "netology_jz" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.0.0/24"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
