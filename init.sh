#!/bin/sh
### Init Script
### Script de inicialização do Projeto

if [ ! -f "prereq.configured" ]; then
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
if [ -f "/root/.ssh/id_rsa" ]; then
	echo "Chave SSH Existente";
else
	echo "Criando chave SSH";
	ssh-keygen -t rsa -b 2048 -q -P '';
fi

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
touch prereq.configured
fi

if [ ! -f awscli.configured ]; then
while true;
do
    read -p "Deseja configurar o AWSCLI? Y/N " RESP
    case $RESP in
        Y|y) sudo aws configure; echo 'Alterar a profile para "[iam_user]" e/ou ajustes customizados necessários'; touch awscli.configured; break;;
        N|n) echo 'Alterar a profile para "[iam_user]" e/ou ajustes customizados necessários'; touch awscli.configured; exit;;
        * ) echo "Resposta: ${yes} / ${no}.";;
    esac
done

else
# Gera script para criação do usuário ansible na EC2 instance
KEY=`cat /root/.ssh/id_rsa.pub`
echo "#!/bin/sh
useradd ansible
mkdir -p /home/ansible/.ssh
usermod -aG docker ansible
chmod 0700 /home/ansible/.ssh
echo '${KEY}' > /home/ansible/.ssh/authorized_keys
chmod 0600 /home/ansible/.ssh/authorized_keys
chown -R ansible /home/ansible
echo 'ansible ALL=NOPASSWD: ALL' >> /etc/sudoers" > /srv/challenge/terraform/scripts/create-users.sh

# Executa TERRAFORM
cd /srv/challenge/terraform/
/usr/local/bin/terraform init
/usr/local/bin/terraform validate
/usr/local/bin/terraform plan
/usr/local/bin/terraform apply

fi
## EoF
