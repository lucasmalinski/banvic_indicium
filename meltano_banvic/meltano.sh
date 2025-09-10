#!/usr/bin/env bash

# Helper script utilizando o meltano através da imagem meltano/meltano:latest para configurar o meltano antes da construção da imagem docker 

docker run \
    -u $(id -u):$(id -g) \
    -e HOME=/projects \
    -v "$(pwd)":/projects \
    -w /projects \
    meltano/meltano:latest-python3.12 "$@"
