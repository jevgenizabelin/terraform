provider "aws" {
  profile = "jz-s3"
  region = "us-west-2"
}

resource "aws_s3_bucket" "jz-bucket" {
  bucket = "jz-netology-bucket-02"
  acl = "private"
}

#resource "aws_dynamodb_table" "jz-dynamodb-table" {
#  name           = "netology-terraform-locks"
#  billing_mode   = "PROVISIONED"
#  read_capacity  = 5
#  write_capacity = 5
#  hash_key       = "LockID"

#  attribute {
#    name = "LockID"
#    type = "S"
#  }
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

