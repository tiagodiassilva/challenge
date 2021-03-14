#!/bin/sh

# Realiza upgrade do pacotes instalados no SO
apt -y update
apt -y -qq upgrade

# Realiza instalação do Python (pre-requisito do Ansible)
apt -y -qq install python

# Realiza instalação do Ansible
apt -y -qq install ansible

# Realiza instalação do unzip
apt -y -qq install unzip

# Realiza instalação do Git
apt -y -qq install git git-flow

# Limpa pacotes desnecessários
apt -y autoremove

# generating password configuration on ansible server to later access remote servers
ssh-keygen -t rsa -b 2048 -f /srv/Projects/ssh/iam.pem -q -P ''
chmod 400 /srv/Projects/ssh/iam.pem
ssh-keygen -y -f /srv/Projects/ssh/iam.pem | tee -a /srv/Projects/ssh/iam.pub

# Install Terraform
wget https://releases.hashicorp.com/terraform/terraform_0.14.5_linux_amd64.zip
sudo unzip terraform_0.14.5_linux_amd64.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
wget https://github.com/adammck/terraform-inventory/releases/download/v0.8/terraform-inventory_v0.8_linux_amd64.zip
sudo unzip terraform-inventory_v0.8_linux_amd64.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform-inventory
