
# ASG with Launch template
resource "aws_launch_template" "sh_ec2_launch_templ" {
  name_prefix   = var.instance_name
  image_id      = var.ami_linux
  instance_type = var.instance_type
  user_data     = filebase64(var.user_data_script_path)

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

  name             = var.asg_name
  desired_capacity = var.asg_desired_size
  max_size         = var.asg_max_size
  min_size         = var.asg_min_size

  # target_group_arns = [aws_lb_target_group.sh_alb_tg.arn]

  vpc_zone_identifier = [
    aws_subnet.sh_public_subnet_1.id,
  ]

  launch_template {
    id      = aws_launch_template.sh_ec2_launch_templ.id
    version = "$Latest"
  }

}
