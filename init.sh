#!/bin/sh
### Init Script
### Script de inicialização do Projeto
### Autor: Tiago Dias da Silva
### IMPORTANTE: Leia o arquivo README.md antes de executar

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

# Criar chave SSH
mkdir /srv/challenge/ssh
ssh-keygen -t rsa -b 2048 -f /srv/challenge/ssh/iam.pem -q -P ''
chmod 400 /srv/challenge/ssh/iam.pem
ssh-keygen -y -f /srv/challenge/ssh/iam.pem | tee -a /srv/challenge/ssh/iam.pub

# Install Terraform
mkdir /srv/challenge/pacotes/
cd /srv/challenge/pacotes/
wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
sudo unzip terraform_0.14.7_linux_amd64.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
wget https://github.com/adammck/terraform-inventory/releases/download/v0.8/terraform-inventory_v0.8_linux_amd64.zip
sudo unzip terraform-inventory_v0.8_linux_amd64.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform-inventory
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Gera script para criação do usuário ansible na EC2 instance
KEY=`cat /srv/challenge/ssh/iam.pub`
echo "#!/bin/sh
useradd ansible
mkdir -p /home/ansible/.ssh
usermod -aG docker ansible
chmod 0700 /home/ansible/.ssh
echo '${KEY}' > /home/ansible/.ssh/authorized_keys
chmod 0600 /home/ansible/.ssh/authorized_keys
chown -R ansible /home/ansible" > /srv/challenge/terraform/scripts/create-users.sh

# Executa TERRAFORM
cd /srv/challenge/terraform/
/usr/local/bin/terraform init
/usr/local/bin/terraform apply
## EoF
