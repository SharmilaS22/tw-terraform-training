
data "aws_instances" "asg_instances" {
  instance_tags = {
    "aws:autoscaling:groupName" = var.asg_name
  }

  instance_state_names = ["running"]
}