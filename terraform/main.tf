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
  mock_data_files  = fileset("${path.module}/../mock_data", "**/*")
  mock_data_path   = "${path.module}/../mock_data"
  glue_script_file = "glue_job.py"
  glue_script_path = "${path.module}/../scripts"
}

module "s3" {
  source           = "./modules/s3"
  account_id       = data.aws_caller_identity.current.account_id
  prefix           = var.prefix
  s3_bucket_names  = var.s3_bucket_names
  mock_data_files  = local.mock_data_files
  mock_data_path   = local.mock_data_path
  glue_script_file = local.glue_script_file
  glue_script_path = local.glue_script_path
}

module "glue" {
  source         = "./modules/glue"
  prefix         = var.prefix
  source_bucket  = module.s3.bucket_names[0]
  target_bucket  = module.s3.bucket_names[1]
  script_bucket  = module.s3.bucket_names[2]
  glue_role_arn  = module.iam.glue_role_arn
  s3_glue_script = module.s3.glue_script
  depends_on     = [module.s3]
}

module "iam" {
  source     = "./modules/iam"
  account_id = data.aws_caller_identity.current.account_id
  prefix     = var.prefix
}

module "lambda" {
  source            = "./modules/lambda"
  prefix            = var.prefix
  crawler_name      = module.glue.source_crawler_name
  source_bucket     = module.s3.bucket_names[0]
  source_bucket_arn = module.s3.source_bucket_arn
  lambda_role_arn   = module.iam.lambda_role_arn
}