#!/bin/sh
set -e

# Definir id de grupo e usuário para evitar que meltano rode como root
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# Helper script utilizando o meltano através da imagem meltano-banvic já built. 
docker compose run --rm meltano "$@"