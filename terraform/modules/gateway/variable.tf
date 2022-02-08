variable "aws_api_gateway_rest_api_name" {
  type    = string
  default = "course-app-api-gateway-terraform"
}
variable "course_list_title_get_lambda_arn" {
  description = "course_list_title_get_lambda_arn"
}

variable "course_detail_get_lambda_arn" {
  description = "course_detail_get_lambda_arn"
}

variable "course_option_lambda_arn" {
  description = "course_option_lambda_arn"
}

variable "course_get_lambda_arn" {
  description = "course_get_lambda_arn"
}

variable "user_course_post_lambda_arn" {
  description = "user_course_post_lambda_arn"
}

variable "user_course_get_lambda_arn" {
  description = "user_course_get_lambda_arn"
}

variable "user_course_detail_put_lambda_arn" {
  description = "user_course_detail_put_lambda_arn"
}

variable "user_course_detail_get_lambda_arn" {
  description = "user_course_detail_get_lambda_arn"
}
