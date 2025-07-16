variable "instance_type" {}
variable "key_name" {}
variable "security_group_id" {}
variable "subnet_id" {}
variable "volume_size" {}
variable "instance_tag" {}

variable "ami_id" {
  description = "AMI ID à utiliser pour l'instance EC2"
  type        = string
}

variable "private_key_pem" {
  description = "Contenu de la clé privée pour SSH"
  type        = string
  sensitive   = true
}

variable "associate_eip" {
  description = "Whether to allocate and associate an Elastic IP to the instance"
  type        = bool
  default     = false
}
