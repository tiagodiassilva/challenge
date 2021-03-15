variable "aws_region" {
  description = "Região para criação da Instancia"
  default = "sa-east-1"
}

variable "ami" {
  description = "AMI Instance"
  default = "ami-0dec7a53c83222c6f"
}

variable "instance_type" {
  description = "Tipo da instancia"
  default = "t2.nano"
}

variable "public_key" {
  default = "/root/.ssh/id_rsa.pub"
}

variable "private_key" {
  default = "/root/.ssh/id_rsa"
}

variable "ansible_user" {
  default = "ansible"
}

variable "bootstrap_path" {
  description = "Script para criar usuario do Ansible"
  default = "/srv/challenge/terraform/scripts/create-users.sh"
}
