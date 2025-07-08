module "key_pair" {
  source   = "../modules/key_pair"
  key_name = "jenkins-key"
}

module "security_group" {
  source = "../modules/security_group"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


module "ec2" {
  source            = "../modules/ec2"
  instance_type     = var.instance_type
  key_name          = module.key_pair.key_name
  private_key_pem   = module.key_pair.private_key_pem
  security_group_id = module.security_group.security_group_id
  subnet_id         = var.subnet_id
  volume_size       = var.volume_size
  instance_tag      = var.instance_tag
  ami_id            = data.aws_ami.ubuntu.id  
  
  associate_eip     = true
}

# variable "aws_access_key_id" {
#   description = "AWS access key ID"
#   type        = string
#   sensitive   = true
# }

# variable "aws_secret_access_key" {
#   description = "AWS secret access key"
#   type        = string
#   sensitive   = true
# }

# provider "aws" {
#   region  = var.region
#   profile = "cfk-credentials"
# }

resource "local_file" "jenkins_output" {
  content  = <<EOT
Public IP: ${module.ec2.public_ip}
Public DNS: ${module.ec2.public_dns}
Elastic IP: ${module.ec2.elastic_ip != null ? module.ec2.elastic_ip : "No Elastic IP assigned"}

EOT
  filename = "${path.module}/jenkins_ec2.txt"
}

