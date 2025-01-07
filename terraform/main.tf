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

locals {
  mock_data_files = fileset("${path.module}/../mock_data", "**/*")
  mock_data_path  = "${path.module}/../mock_data"
}

module "s3" {
  source          = "./modules/s3"
  account_id      = data.aws_caller_identity.current.account_id
  prefix          = var.prefix
  s3_bucket_names = var.s3_bucket_names
  mock_data_files = local.mock_data_files
  mock_data_path  = local.mock_data_path
}

module "glue" {
  source = "./modules/glue"
}

module "iam" {
  source     = "./modules/iam"
  account_id = data.aws_caller_identity.current.account_id
  prefix     = var.prefix
}