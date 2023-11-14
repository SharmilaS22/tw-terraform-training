
resource "aws_autoscaling_policy" "sh_scale_out_policy" {
  name                   = "sh-scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.sh_asg.name
}

resource "aws_autoscaling_policy" "sh_scale_in_policy" {
  name                   = "sh-scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.sh_asg.name
}

resource "aws_cloudwatch_metric_alarm" "example" {
  alarm_name          = "sh-cpu-utilization"
  alarm_description   = "Scale instances based on CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.sh_scale_out_policy.arn, aws_autoscaling_policy.aws_autoscaling_policy.sh_scale_in_policy.arn]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
}