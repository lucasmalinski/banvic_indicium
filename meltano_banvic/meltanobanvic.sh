#!/bin/sh
set -e

# Helper script utilizando o meltano através da imagem meltano-banvic já built. 
docker compose run --rm meltano "$@"