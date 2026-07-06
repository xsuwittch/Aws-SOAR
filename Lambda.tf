# zip the python code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda/quarantine.py"
  output_path = "lambda/quarantine.zip"
}

# lambda function
resource "aws_lambda_function" "quarantine_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "quarantine-ec2"
  role             = aws_iam_role.Lambda_access.arn
  handler          = "quarantine.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      QUARANTINE_SG_ID = aws_security_group.quarantine_sg.id
    }
  }
}

# allow eventbridge to invoke the lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.quarantine_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.guardduty_finding_rule.arn
}