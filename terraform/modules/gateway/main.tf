resource "aws_api_gateway_rest_api" "course_app_api_gateway" {
  name = "course-app-api-gateway"
  endpoint_configuration {
    types = ["REGIONAL"]
  }

}

resource "aws_api_gateway_resource" "course" {
  rest_api_id = aws_api_gateway_rest_api.course_app_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.course_app_api_gateway.root_resource_id
  path_part   = "course"
}

resource "aws_api_gateway_method" "get" {
  rest_api_id      = aws_api_gateway_rest_api.course_app_api_gateway.id
  resource_id      = aws_api_gateway_resource.course.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "course_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.course_app_api_gateway.id
  resource_id             = aws_api_gateway_resource.course.id
  http_method             = aws_api_gateway_method.get.http_method
  integration_http_method = "POST"
  // MOCK
  type = "AWS_PROXY"
  uri  = var.course_get_lambda_arn.invoke_arn
}



resource "aws_api_gateway_deployment" "course_app_get_deployment" {
  rest_api_id = aws_api_gateway_rest_api.course_app_api_gateway.id
  depends_on = [
    aws_api_gateway_integration.course_get_integration
  ]
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.course_get_lambda_arn.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.course_app_api_gateway.execution_arn}/*/*"
  depends_on = [
    aws_api_gateway_rest_api.course_app_api_gateway
  ]
}



output "aws_api_gateway_rest_api" {
  value = aws_api_gateway_rest_api.course_app_api_gateway
}
