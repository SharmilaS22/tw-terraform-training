
resource "aws_security_group" "sh_sg_for_ec2" {
  name   = "sharmi-sg"
  vpc_id = aws_vpc.sh_vpc_main.id

  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      description      = "Allow request from anywhere"
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
