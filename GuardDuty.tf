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