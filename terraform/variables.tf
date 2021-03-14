variable "aws_region" {
  description = "AWS region for setup Docker"
  default = "sa-east-1"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-0dec7a53c83222c6f"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.nano"
}

variable "public_key" {
  default = "~/.ssh/iam.pub"
}

variable "private_key" {
  default = "~/.ssh/iam.pem"
}

variable "ansible_user" {
  default = "ansible"
}

variable "bootstrap_path" {
  description = "Script para criar usuario do Ansible"
  default = "./scripts/create-user.sh"
}
