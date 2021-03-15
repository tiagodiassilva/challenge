# INTRODUÇÃO

# challenge
Repository for challenge teste

# PRÉ-REQS
Python
Ansible
AWSCLI v2
Terraform 0.14.7
GIT
* todos os pre-reqs resolvidos pelo script `init.sh`.

# GIT Clone
Realizar o GIT clone a partir do PATH /srv, como abaixo.

```
$ sudo su -
# cd /srv
# git clone https://github.com/tiagodiassilva/challenge.git
```

# Antes de executar o projeto
Criar o arquivo credentials enviado por email e adicionar ao PATH abaixo
`/root/.aws/credentials`
- caso prefira utilizar uma credencial já configurado é necessário atualizar os arquivos `provider.tf` e `variables.tf`.

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
- terraform.tf - versão necessária do terraform
- provider.tf  - configurações das crendenciais de acesso / região utilizada
- resources.tf - criação da instância EC2, criação do VPC, criação de volumes adicionais, execução de scripts para atividades post-install (chamado do Ansible)
- outputs.tf   - serial utilizado para criação do inventário dinâmico caso fosse necessário várias instências (como só temos uma instância a criação do inventário e através do `local-exec` e o inventário temporário é adicionado ao arquivo `/srv/challenge/terraform/docker.ini`

# Detalhamento: ANSIBLE
- install_docker.yaml - playbook para instalação e configuração do Docker
- deploy_docker.yaml - playbook para deploy das instâncias Docker: configuração das imagens NGINX e GOLANG. 

# Detalhamento: DOCKER
- env/app/Dockerfile - arquivo que realiza a configuração imagem GOLANG utilizando Multistage para compilação da aplicação `main.go`.
- env/nginx/Dockerfile - arquivo que realizada a configuração da imagem NGINX com suporte à HTTP, HTTPS, redirect e upstream server.

# Detalhamento: CONTAINERS
- go-app - imagem reduzida utilizando somente o necessário para executar a aplicação compilada.
- ngix - imagem padrão com arquivo de configuração customizado para utilizar HTTPS (SSL), HTTP Redirect e Upstream Server (direcionamento para a aplicação no contrainer `go-app` que responde na porta TCP 8080.

# COMO ACESSAR?
Obter o Public IP Address no arquivo `/srv/challenge/terraform/docker.ini`.

`SSH`
```
# ssh ubuntu@public_ip
```

`WEB`
```
http://public_ip
```
