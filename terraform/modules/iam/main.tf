
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com", "apigateway.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role_policy_attachment" "iam_for_lambda-role-policy-attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AWSLambdaInvocation-DynamoDB",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
  ])

  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = each.value
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

output "iam_for_lambda" {
  value = aws_iam_role.iam_for_lambda.arn
}
