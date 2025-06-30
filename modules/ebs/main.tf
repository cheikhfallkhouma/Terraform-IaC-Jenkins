resource "aws_ebs_volume" "jenkins_ebs" {
  availability_zone = var.availability_zone
  size              = var.size
  tags = {
    Name = "jenkins-ebs"
  }
}
