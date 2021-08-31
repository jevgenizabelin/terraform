provider "aws" {
  profile = "jz-s3"
  region = "us-west-2"
}

#resource "aws_s3_bucket" "jz-bucket" {
#  bucket = "jz-netology-bucket-02"
#  acl = "private"
#}

terraform {
  backend "s3" {
    bucket = "jz-netology-bucket-02"
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
    profile = "jz-s3"
    dynamodb_table = "netology-terraform-locks"
  }
}

locals {
  web_instance_type_map = {
    stage = "t3.micro"
    prod = "t3.large"
  }
}

locals {
  web_instance_count_map = {
    stage = 1
    prod = 2
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.web_instance_type_map[terraform.workspace]
  count = local.web_instance_count_map[terraform.workspace]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Netology_test"
  }

}

variable "db_instance" {
    prod = "t2.large"
    stage = "t2.nano"
}

#variable "db_instance" {
#   type        = map
#   default = {
#     test_db = {
#     ins = "t2.nano",
#     environment = "stage"
#   },

#     big_db = {
#     ins = "t2.large",
#     environment = "prod"
#   }
#  }
#}

resource "aws_instance" "db" {
  for_each = var.db_instance
  ami           = "ami-0b28dfc7adc325ef4"
  instance_type = each.value
  

#  tags = {
#    Name = "Workspace ${each.key}"
#  }
}
