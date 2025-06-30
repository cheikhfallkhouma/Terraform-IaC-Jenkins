output "public_ip" {
  value = aws_eip.jenkins_ip.public_ip
}
