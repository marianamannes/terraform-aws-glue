terraform {
  backend "s3" {
    bucket         = "tf-glue-project-tf-state-992382585159"
    key            = "tf-glue-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state"
  }
}
