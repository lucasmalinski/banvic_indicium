#!/bin/bash
set -e

# Permissões de pastas e environment do airflow

echo -e "AIRFLOW_UID=$(id -u)" > airflow/.env
echo -e "AIRFLOW_UID=$(id -u)" > ./.env
mkdir -p airflow/dags airflow/logs airflow/plugins airflow/config
sudo chown -R "$(id -u):$(id -u)" airflow/dags airflow/logs airflow/plugins airflow/config
sudo chmod -R 755 airflow/dags airflow/logs airflow/plugins airflow/config

BUILD imagem meltano pré-configurada 

docker build -t "meltano-banvic:latest" "meltano_banvic"

POSTGRES do Banvic

docker compose -f postgres_banvic/docker-compose.yml up -d 

# POSTGRES do datawarehouse
docker compose -f data_warehouse/docker-compose.yml up -d 

# AIRFLOW
cd airflow
docker compose up airflow-init --force-recreate && docker compose up -d  --force-recreate
