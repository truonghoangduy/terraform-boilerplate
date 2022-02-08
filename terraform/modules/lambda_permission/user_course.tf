
locals {
  course_lambda_function_name = "user_course_lambda-terraform"
  course_lambda_file          = "user_course.js"
  #
  course_lambda_function_zip_name = "user_course.zip"
}

data "aws_lambda_function" "user_course_lambda" {
  function_name = local.course_lambda_function_name
}


resource "aws_lambda_permission" "user_course_app_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.user_course_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.aws_api_gateway_rest_api.execution_arn}/*/*"
}
