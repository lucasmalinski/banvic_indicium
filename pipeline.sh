#!/bin/bash
set -e

# Permissões de pastas e environment do airflow
mkdir -p airflow/dags airflow/logs airflow/plugins airflow/config
echo -e "AIRFLOW_UID=$(id -u)" > airflow/.env
echo -e "AIRFLOW_UID=$(id -u)" > .env
# Grupo Airflow - Docker 
echo "DOCKER_GID=$(stat -c %g /var/run/docker.sock)" >> airflow/.env
echo "DOCKER_GID=$(stat -c %g /var/run/docker.sock)" >> .env

# POSTGRES - Banvic
docker compose -f postgres_banvic/docker-compose.yml down 
docker compose -f postgres_banvic/docker-compose.yml up -d 

# POSTGRES - datawarehouse
docker compose -f data_warehouse/docker-compose.yml down 
docker compose -f data_warehouse/docker-compose.yml up -d 

# MELTANO - BUILD imagem meltano pré-configurada 
docker compose -f meltano/docker-compose.yml down 
docker build -t "meltano-banvic:latest" "meltano"

# AIRFLOW
cd airflow
docker compose down --volumes --remove-orphans
docker compose up airflow-init
docker compose up -d 
docker exec -it airflow-scheduler airflow dags unpause pipeline


