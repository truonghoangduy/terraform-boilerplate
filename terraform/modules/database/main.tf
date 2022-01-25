resource "aws_dynamodb_table" "course_app_dynamodb" {
  name           = var.database_name
  hash_key       = "id"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "id"
    type = "N"
  }


  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}
