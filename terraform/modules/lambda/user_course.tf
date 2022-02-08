
locals {
  course_lambda_function_name = "user_course_lambda-terraform"
  course_lambda_file          = "user_course.js"
  #
  course_lambda_function_zip_name = "user_course.zip"
}

data "archive_file" "lambda_user_course_source_zip" {
  type        = "zip"
  source_file = "${path.module}/../../../functions/${local.course_lambda_file}"
  output_path = "${path.module}/../../.build/${local.course_lambda_function_zip_name}"
}



resource "aws_lambda_function" "user_course_lambda" {
  filename = "${path.module}/../../.build/${local.lambda_function_zip_name}"
  role     = var.aws_iam_role
  #   source_code_hash = filebase64sha256("${path.module}/../../.build/${local.lambda_function_zip_name}")

  handler       = "course.handler"
  description   = "course_app AWS lambda"
  runtime       = "nodejs12.x"
  function_name = local.course_lambda_function_name
}

## MOCK
## LAMBDA FUNCTION COMPILE ALL HTTP METHOD
output "user_course_lambda" {
  value = aws_lambda_function.user_course_lambda
}
