resource "aws_guardduty_detector" "GuardDuty" {
  enable = true

}

resource "aws_sns_topic" "guardduty_sns_topic" {
  name = "guardduty_sns_topic"
  
}

resource "aws_sns_topic_subscription" "guardduty_sns_subscription" {
  topic_arn = aws_sns_topic.guardduty_sns_topic.arn
  protocol  = "email"
  endpoint  = "ammarworksonline@gmail.com"
}

resource "aws_cloudwatch_event_rule" "guardduty_finding_rule" {
  name        = "guardduty-finding-rule"
  description = "Capture GuardDuty findings"
  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
  })
}

resource "aws_cloudwatch_event_target" "guardduty_finding_target" {
  rule      = aws_cloudwatch_event_rule.guardduty_finding_rule.name
  target_id = "GuardDutyFindingTarget"
  arn       = aws_sns_topic.guardduty_sns_topic.arn
}