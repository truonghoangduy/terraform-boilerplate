terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "iam" {
  source = "./modules/iam"
}

module "database" {
  source = "./modules/database"
}

module "lambda" {
  source       = "./modules/lambda"
  aws_iam_role = module.iam.iam_for_lambda
  depends_on = [
    module.iam,
  ]
}

module "api-gateway" {
  source                = "./modules/gateway"
  course_get_lambda_arn = module.lambda.course_get_lambda_arn
  depends_on = [
    module.lambda,
  ]
}



