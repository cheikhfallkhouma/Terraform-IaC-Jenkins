variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "availability_zone" {
  description = "The availability zone in which to create the EBS volume"
  type        = string
}
variable "size" {
  description = "The size of the EBS volume in GiB"
  type        = number
  default     = 15
}