variable "region" {
  type        = string
  description = "course_app backend infrastructure region"
  default     = "ap-southeast-1"
}
variable "aws_api_gateway_rest_api_name" {
  type    = string
  default = "course-app-api-gateway-terraform"
}
