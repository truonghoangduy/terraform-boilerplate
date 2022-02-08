terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"

    }
  }
}

provider "aws" {
  region = var.region
}

module "iam" {
  source = "./modules/iam"
}

module "database" {
  source = "./modules/database"
}

module "lambda" {
  source                        = "./modules/lambda"
  aws_iam_role                  = module.iam.iam_for_lambda
  aws_api_gateway_rest_api_name = var.aws_api_gateway_rest_api_name
  depends_on = [
    module.iam,
  ]
}

module "api-gateway" {
  source                        = "./modules/gateway"
  aws_api_gateway_rest_api_name = var.aws_api_gateway_rest_api_name

  ##  MOCK
  course_list_title_get_lambda_arn = module.lambda.course_get_lambda.invoke_arn
  course_detail_get_lambda_arn     = module.lambda.course_get_lambda.invoke_arn
  course_option_lambda_arn         = module.lambda.course_get_lambda.invoke_arn
  course_get_lambda_arn            = module.lambda.course_get_lambda.invoke_arn
  #
  user_course_post_lambda_arn       = module.lambda.user_course_lambda.invoke_arn
  user_course_get_lambda_arn        = module.lambda.user_course_lambda.invoke_arn
  user_course_detail_put_lambda_arn = module.lambda.user_course_lambda.invoke_arn
  user_course_detail_get_lambda_arn = module.lambda.user_course_lambda.invoke_arn

  #
  depends_on = [
    module.lambda,
  ]
}

module "lambda_permission" {
  aws_api_gateway_rest_api = module.api-gateway.aws_api_gateway_rest_api
  source                   = "./modules/lambda_permission"
  depends_on = [
    module.lambda,
    module.api-gateway
  ]
}



