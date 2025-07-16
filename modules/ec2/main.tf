
resource "aws_instance" "jenkins" {
  ami                          = var.ami_id
  instance_type                = var.instance_type
  subnet_id                    = var.subnet_id
  key_name                     = var.key_name
  associate_public_ip_address  = true
  vpc_security_group_ids       = [var.security_group_id]
  tags = {
    Name = var.instance_tag
  }

  provisioner "remote-exec" {
    script = "${path.module}/install_jenkins.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key_pem
      host        = self.public_ip
    }
  }

  # provisioner "local-exec" {
  #   command = <<EOT
  #     echo "Public IP: ${self.public_ip}" > jenkins_ec2.txt
  #     echo "Elastic IP: ${aws_eip.this[0].public_ip != null ? aws_eip.this[0].public_ip : "No Elastic IP assigned"}" >> jenkins_ec2.txt
  #     echo "Public DNS: ${self.public_dns}" >> jenkins_ec2.txt
  #         EOT
  # }
}
resource "aws_eip" "this" {
  count    = var.associate_eip ? 1 : 0
  instance = aws_instance.jenkins.id

}
