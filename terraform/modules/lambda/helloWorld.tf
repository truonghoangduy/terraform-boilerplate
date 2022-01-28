# # zip all functions files

# variable "aws_iam_role" {
#   type = string
# }


# data "archive_file" "lambda_source_zip" {
#   type        = "zip"
#   source_file = "${path.module}/../../../functions/helloworld.js"
#   output_path = "${path.module}/../../.build/helloworld.zip"
# }



# resource "aws_lambda_function" "helloworld" {
#   filename         = "${path.module}/../../.build/helloworld.zip"
#   role             = var.aws_iam_role
#   source_code_hash = filebase64sha256("${path.module}/../../.build/helloworld.zip")

#   handler       = "helloworld.handler"
#   description   = "course_app AWS lambda"
#   runtime       = "nodejs12.x"
#   function_name = "helloworld"
# }




# output "course_get_lambda_arn" {
#   value = aws_lambda_function.helloworld
# }
