output "public_ip" {
  value = var.associate_eip ? aws_eip.this[0].public_ip : aws_instance.jenkins.public_ip
}

output "public_dns" {
  value = aws_instance.jenkins.public_dns
}

output "instance_id" {
  value = aws_instance.jenkins.id
}

output "elastic_ip" {
  value = var.associate_eip ? aws_eip.this[0].public_ip : null
}
