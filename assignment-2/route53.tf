
resource "aws_route53_record" "sh_dns_record" {
  zone_id = var.hosted_zone_id
  name    = "sharmi"
  type    = "A"
  ttl     = "300"

  records = [
    for public_ip in data.aws_instances.asg_instances.public_ips :
    public_ip
  ]

  depends_on = [aws_autoscaling_group.sh_asg]
}
