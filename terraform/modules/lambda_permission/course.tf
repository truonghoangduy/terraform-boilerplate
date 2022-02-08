
locals {
  lambda_function_name = "course_lambda-terraform"
  lambda_file          = "course.js"
  #
  lambda_function_zip_name = "course.zip"
}

data "aws_lambda_function" "course_lambda" {
  function_name = local.lambda_function_name
}

resource "aws_lambda_permission" "course_app_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.course_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.aws_api_gateway_rest_api.execution_arn}/*/*"
}
