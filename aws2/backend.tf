terraform {
  backend "s3" {
    bucket = "jz-netology-bucket"
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
    profile = "jz-s3"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  profile = "jz-s3"
  region = "us-west-2"
}

#data "terraform_remote_state" "remote_state" {
#  backend = "s3"

#  config = {
#    bucket   = "jz-netology-bucket"
#    region   = "us-west-2"
#    key      = "dev/terraform.tfstate"
#  }
#}
