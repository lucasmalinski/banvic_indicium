#!/bin/bash
set -e

# Instruções environment airflow
mkdir -p airflow/dags airflow/logs airflow/plugins airflow/config
echo -e "AIRFLOW_UID=$(id -u)" > airflow/.env
echo -e "AIRFLOW_UID=$(id -u)" > ./.env


# BUILD imagem meltano pré-configurada 

# docker build -t "meltano-banvic:latest" "meltano_banvic"

# POSTGRES do Banvic

docker compose -f postgres_banvic/docker-compose.yml up -d 

# POSTGRES do datawarehouse
docker compose -f data_warehouse/docker-compose.yml up -d 

# AIRFLOW
cd airflow
docker build -t airflow-meltano:latest .
docker compose up airflow-init
echo "Esperando airflow-init..."
sleep 30
docker compose up -d 