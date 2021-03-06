provider "aws" {
  profile = "jz-s3"
  region = "us-west-2"
}

resource "aws_dynamodb_table" "jz-dynamodb-table" {
  name           = "netology-terraform-locks"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

