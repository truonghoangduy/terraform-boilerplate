# zip all functions files

variable "aws_iam_role" {
  type = string
}


data "archive_file" "lambda_source_zip" {
  type        = "zip"
  source_file = "${path.module}/../../../functions/course.js"
  output_path = "${path.module}/../../.build/course.zip"
}



resource "aws_lambda_function" "course_lambda" {
  filename = "${path.module}/../../.build/course.zip"
  role     = var.aws_iam_role
  # source_code_hash = filebase64sha256("${path.module}/../../.build/course.zip")

  handler       = "course.handler"
  description   = "course_app AWS lambda"
  runtime       = "nodejs12.x"
  function_name = "course-terrafrom-demo"
}




output "course_get_lambda_arn" {
  value = aws_lambda_function.course_lambda
}
