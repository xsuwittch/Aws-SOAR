resource "aws_iam_role" "Lambda_access" {
  name = "Lambda access to instance attributes"
  assume_role_policy = jsondecode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda-remediation-policy"
  role   = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = [
        "ec2:ModifyInstanceAttribute",
        "ec2:DescribeInstances"
      ]
      Resource = "*"
    }]
  })
}