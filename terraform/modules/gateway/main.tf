data "template_file" "config_swagger_gateway_lambda" {
  template = file("${path.module}/course-app-swagger-apigateway.yaml")

  vars = {
    course_list_title_get_lambda_arn  = var.course_list_title_get_lambda_arn
    course_detail_get_lambda_arn      = var.course_detail_get_lambda_arn
    course_option_lambda_arn          = var.course_option_lambda_arn
    course_get_lambda_arn             = var.course_get_lambda_arn
    user_course_post_lambda_arn       = var.user_course_post_lambda_arn
    user_course_get_lambda_arn        = var.user_course_get_lambda_arn
    user_course_detail_put_lambda_arn = var.user_course_detail_put_lambda_arn
    user_course_detail_get_lambda_arn = var.user_course_detail_get_lambda_arn
  }
}

resource "aws_api_gateway_rest_api" "course_app_api_gateway" {
  name = var.aws_api_gateway_rest_api_name

  description = "course app REST API"
  body        = data.template_file.config_swagger_gateway_lambda.rendered

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}

resource "aws_api_gateway_deployment" "course_app_get_deployment" {
  rest_api_id = aws_api_gateway_rest_api.course_app_api_gateway.id
  # triggers = {
  #   re
  # }

}

# resource "aws_lambda_permission" "apigw" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = var.course_get_lambda_arn.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.course_app_api_gateway.execution_arn}/*/*"
#   depends_on = [
#     aws_api_gateway_rest_api.course_app_api_gateway
#   ]
# }

output "gateway_url" {
  value = aws_api_gateway_deployment.course_app_get_deployment.invoke_url
}

output "aws_api_gateway_rest_api" {
  value = aws_api_gateway_rest_api.course_app_api_gateway
}
