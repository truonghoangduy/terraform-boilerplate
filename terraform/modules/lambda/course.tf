
locals {
  lambda_function_name = "course_lambda-terraform"
  lambda_file          = "course.js"
  #
  lambda_function_zip_name = "course.zip"
}

data "archive_file" "lambda_course_source_zip" {
  type        = "zip"
  source_file = "${path.module}/../../../functions/${local.lambda_file}"
  output_path = "${path.module}/../../.build/${local.lambda_function_zip_name}"
}



resource "aws_lambda_function" "course_lambda" {
  filename = "${path.module}/../../.build/${local.lambda_function_zip_name}"
  role     = var.aws_iam_role
  # source_code_hash = filebase64sha256("${path.module}/../../.build/course.zip")

  handler       = "course.handler"
  description   = "course_app AWS lambda"
  runtime       = "nodejs12.x"
  function_name = "course_lambda-terraform"
}


output "course_get_lambda" {
  value = aws_lambda_function.course_lambda
}
