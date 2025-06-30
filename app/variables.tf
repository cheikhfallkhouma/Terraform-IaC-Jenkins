variable "instance_type" {
  description = "The type of instance to use for the EC2 instance"
  type        = string
  default     = "t3.medium"
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
  default     = "subnet-0e428c3dd8898417d"
}

variable "volume_size" {
  description = "The size of the EBS volume in GB"
  type        = number
  default     = 10
}
variable "instance_tag" {
  description = "Tag to assign to the EC2 instance"
  type        = string
  default     = "Jenkins-Server"
}

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1" 
}
