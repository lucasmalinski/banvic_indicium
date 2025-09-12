#!/bin/bash
set -e

# Permissões de pastas e environment do airflow

echo -e "AIRFLOW_UID=$(id -u)" > airflow/.env

# BUILD imagem meltano pré-configurada 

docker build -t "meltano-banvic:latest" "meltano_banvic"

# POSTGRES do Banvic

docker compose -f postgres_banvic/docker-compose.yml up -d 

# POSTGRES do datawarehouse
docker compose -f data_warehouse/docker-compose.yml up -d 

# AIRFLOW
cd airflow
docker compose up airflow-init --force-recreate && docker compose up -d --force-recreate
