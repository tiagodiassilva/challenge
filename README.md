# INTRODUÇÃO

# challenge
Repository for challenge teste

# PRÉ-REQS
Python
Ansible
AWSCLI v2
Terraform 0.14.7
GIT
* todos os pre-reqs resolvidos pelo script init.sh

# GIT Clone
Realizar o GIT clone a partir do PATH /srv, como abaixo.

```
$ sudo su -
# cd /srv
# git clone https://github.com/tiagodiassilva/challenge.git
```
# Antes de executar o projeto
Criar o arquivo credentials enviado por email ou utilizar um já existe, lembrando que vai ser necessário alterar a profile.
`/root/.aws/credentials`

# Executando o projeto
Após conclusão do Git clonde devemos executar o script `init.sh` (script responsável pela instalação e validação dos pré-requesitos, instalação, configuração e deploy da instância EC2 na AWS.

```
# cd /srv/challenge
# ./init.sh
```

# O que o script faz
- Instala pacotes necessários conforme descrito em `pré-requisitos`
- Gera chave SSH para o usuário local 'root' acessar a instância EC2
- Cria script para criação do usuário `ansible` durante o boot da instância EC2
- Executa o terraform: init, validate, plan e apply

# Detalhamento: TERRAFORM
- variables.tf - arquivo com as variáveis utilizadas pelos demais arquivos
- terraform.tf - versão do terraform
- provider.tf - configurações das crendenciais de acesso / região utilizada
- resources.tf - criação da instância EC2, criação do VPC, criação de volumes adicionais, execução de scripts para atividades post-install (chamado do Ansible)
- outputs.tf - serial utilizado para criação do inventário dinâmico caso fosse necessário várias instências

# Detalhamento: ANSIBLE
- variables.tf - arquivo com as variáveis utilizadas pelos demais arquivos

# Detalhamento: DOCKER
- variables.tf - arquivo com as variáveis utilizadas pelos demais arquivos

# Detalhamento: CONTAINERS
- variables.tf - arquivo com as variáveis utilizadas pelos demais arquivos

# COMO ACESSAR
- variables.tf - arquivo com as variáveis utilizadas pelos demais arquivos

