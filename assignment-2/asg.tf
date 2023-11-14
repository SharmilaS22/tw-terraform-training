
# ASG with Launch template
resource "aws_launch_template" "sh_ec2_launch_templ" {
  name_prefix   = var.instance_name
  image_id      = var.ami_linux
  instance_type = var.instance_type
  user_data     = filebase64("user_data.sh")
  # user_data = file("user_data.sh")
  key_name = var.key_pair_name
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sh_sg_for_ec2.id]
  }
  tags = {
    Name = "Sharmi-asg"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Sharmi-instance"
    }
  }
}

resource "aws_autoscaling_group" "sh_asg" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  # target_group_arns = [aws_lb_target_group.sh_alb_tg.arn]

  vpc_zone_identifier = [
    aws_subnet.sh_public_subnet_1.id,
  ]

  launch_template {
    id      = aws_launch_template.sh_ec2_launch_templ.id
    version = "$Latest"
  }


}
