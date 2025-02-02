terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}



module "api_gateway" {
  source               = "./modules/api_gateway"
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
  project_name         = "aws-github-actions"
  environment          = "dev"
}

module "lambda" {
  source       = "./modules/lambda"
  role_arn     = module.iam.lambda_role_arn
  project_name = "aws-github-actions"
  environment  = "dev"
}

module "iam" {
  source       = "./modules/iam"
  project_name = "aws-github-actions"
}

