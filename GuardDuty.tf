resource "aws_guardduty_detector" "GuardDuty" {
  enable = true

}

resource "aws_sns_topic" "guardduty_sns_topic" {
  name = "guardduty_sns_topic"
  
}
// SNS subscription to receive GuardDuty findings
resource "aws_sns_topic_subscription" "guardduty_sns_subscription" {
  topic_arn = aws_sns_topic.guardduty_sns_topic.arn
  protocol  = "email"
  endpoint  = "ammarworksonline@gmail.com"
}
// EventBridge rule to capture GuardDuty findings

resource "aws_cloudwatch_event_rule" "guardduty_finding_rule" {
  name        = "guardduty-finding-rule"
  description = "Capture GuardDuty findings"
  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
  })
}

// EventBridge target to send GuardDuty findings to the SNS topic
resource "aws_cloudwatch_event_target" "guardduty_finding_target" {
  rule      = aws_cloudwatch_event_rule.guardduty_finding_rule.name
  target_id = "GuardDutyFindingTarget"
  arn       = aws_sns_topic.guardduty_sns_topic.arn
}
//target set to lambda fucntion
resource "aws_cloudwatch_event_target" "guardduty_lambda_target" {
  rule      = aws_cloudwatch_event_rule.guardduty_finding_rule.name
  target_id = "GuardDutyLambdaTarget"
  arn       = aws_lambda_function.quarantine_lambda.arn
}

// policy to allow EventBridge to publish to the SNS topic
resource "aws_sns_topic_policy" "allow_eventbridge" {
  arn = aws_sns_topic.guardduty_sns_topic.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "events.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.guardduty_sns_topic.arn
      }
    ]
  })
}