resource "aws_security_group" "default" {
  name = "sg_docker"
  # Allow all ports
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Habilita PING
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# configura chave ssh
resource "aws_key_pair" "default" {
  key_name   = "iam_user"
  public_key = "${file(var.public_key)}"
}

# cria Docker instance
resource "aws_instance" "docker" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  associate_public_ip_address = true
  user_data = "${file(var.bootstrap_path)}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

# configura disco adicional na docker instance
  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 50
    volume_type           = "io1"
    iops                  = 2000
    encrypted             = true
    delete_on_termination = true
  }

  # envia script remoto para instalação do Ansible
  provisioner "file" {
    source = "/srv/challenge/terraform/scripts/install-ansible.sh"
    destination = "/tmp/install-ansible.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.private_key)}"
      host = "${aws_instance.docker.public_ip}"
    }
  }

  # executa script remoto para instalação do Ansible
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-ansible.sh",
      "sudo /tmp/install-ansible.sh",
    ]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.private_key)}"
      host = "${aws_instance.docker.public_ip}"
    }
  }

  # Configura a docker instance com executando os playbooks do ansible
  provisioner "local-exec" {
    command = <<EOT
      sleep 30;
      >docker.ini;
      echo "[docker]" | tee -a docker.ini;
      echo "${aws_instance.docker.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee -a docker.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
      ansible-playbook -i /srv/challenge/terraform/docker.ini /srv/challenge/ansible/playbooks/install_docker.yaml
      ansible-playbook -i /srv/challenge/terraform/docker.ini /srv/challenge/ansible/playbooks/deploy_docker.yaml
    EOT
  }

  tags = {
    Name = "Docker"
  }
}
