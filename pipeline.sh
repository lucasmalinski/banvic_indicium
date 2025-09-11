#Inicia POSTGRES do Banvic

docker compose -f postgres_banvic/docker-compose.yml up -d

#Inicia POSTGRES do DataWarehouse
docker compose -f data_warehouse/docker-compose.yml up -d

# Inicia AIRFLOW
docker compose -f airflow/docker-compose.yml up -d