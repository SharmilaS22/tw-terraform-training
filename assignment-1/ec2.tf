
# EC2
resource "aws_instance" "sh_ec2_instance" {
  ami                         = var.ami_linux
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.sh_public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.sh_sg_for_ec2.id]
  key_name                    = var.key_pair_name

  connection {
    type = "ssh"
    user = "ec2-user"
    #   password = var.root_password
    private_key = file(var.key_pair_pem_path)
    host        = self.public_ip
  }

  tags = {
    Name = var.instance_name
  }

  provisioner "file" {
    source      = var.user_data_script_path
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]
  }
}
