# output "EC2_Public_IP" {
#   value = aws_instance.sh_ec2_instance.public_ip
# }

output "public_ips" {
  value = data.aws_instances.asg_instances.public_ips
}
output "Domain_name" {
  value = aws_route53_record.sh_dns_record.fqdn
}