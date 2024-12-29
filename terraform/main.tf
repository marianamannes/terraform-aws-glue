terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

module "s3_source" {
  source          = "./modules/s3"
  account_id      = data.aws_caller_identity.current.account_id
  prefix          = var.prefix
  s3_bucket_names = var.s3_bucket_names
}
