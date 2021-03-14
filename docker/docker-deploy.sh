#!/bin/sh
## Cria containers chamando utilizando o arquivo docker-compose.yml
## Cada imagem tenha sua customização utilizando o arquivo Dockerfile
cd /srv/challenge/docker/
docker-compose up --build -d
