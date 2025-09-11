import pendulum
from datetime import timedelta
from airflow.providers.docker.operators.docker import DockerOperator
from airflow import DAG


default_args ={
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5) 
}
with DAG(
    "banvic_pipeline",
    default_args = default_args,
    start_date = pendulum.datetime(2025, 9, 10, 4, 35),
    schedule="35 4 * * *",  # diariamente 04:35
    catchup = False,
    tags = ["banvic"],
) as dag:
    
# [TASKS]

    extrair_csv = DockerOperator(
        task_id = "extrair_csv",
        image="meltano/meltano:latest",
        command="meltano run tap-csv target-csv-csv",
        auto_remove=True,

    )

    extrair_sql = DockerOperator(
        task_id = "extrair_sql",
        image="meltano/meltano:latest",
        command="meltano run tap-postgres target-sql-csv",
        auto_remove=True,

    )

    carregar_dw = DockerOperator(
        task_id = "carregar_dw",
        image="meltano/meltano:latest",
        command="meltano run tap-datalake target-postgres",
        auto_remove=True,

    )

    # Garante que 'carregar_dw' só será executada após 'extrair_csv' e 'extrair_sql' serem concluídas
    [extrair_csv, extrair_sql] >> carregar_dw