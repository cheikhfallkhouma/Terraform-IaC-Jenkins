resource "aws_eip" "jenkins_ip" {
  instance = var.instance_id
}
