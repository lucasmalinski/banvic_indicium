import pendulum
from datetime import timedelta
from airflow.providers.docker.operators.docker import DockerOperator
from airflow import DAG


default_args ={
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=1) 
}
with DAG(
    dag_id="pipeline",
    default_args=default_args,
    start_date=pendulum.datetime(2025, 9, 12, 4, 35, tz="America/Sao_Paulo"),
    schedule="35 4 * * *",  # diariamente 04:35
    catchup=False,
    tags=["banvic"],
) as dag:
    
# [TASKS]

    extrair_csv = DockerOperator(
        task_id = "extrair_csv",
        image="meltano-banvic:latest",
        command="run tap-transacoes target-pasta-csv",
        auto_remove="force",
        mount_tmp_dir=False
    )

    extrair_sql = DockerOperator(
        task_id = "extrair_sql",
        image="meltano-banvic:latest",
        command="run tap-postgres target-pasta-sql",
        auto_remove="force",
        network_mode="banvicnet",
        mount_tmp_dir=False
    )

    carregar_csv_datalake = DockerOperator(
        task_id = "carregar_csv_datalake",
        image="meltano-banvic:latest",
        command="run tap-transacoes target-datalake",
        auto_remove="force",
        mount_tmp_dir=False
    )    

    carregar_sql_datalake = DockerOperator(
        task_id = "carregar_sql_datalake",
        image="meltano-banvic:latest",
        command="run tap-postgres target-datalake",
        auto_remove="force",
        network_mode="banvicnet",
        mount_tmp_dir=False
    )    

    carregar_warehouse = DockerOperator(
        task_id = "carregar_dw",
        image="meltano-banvic:latest",
        command="run tap-datalake target-postgres",
        auto_remove="force",
        network_mode="indicium",
        mount_tmp_dir=False
    )

    # Extrações
    extrair_csv >> carregar_csv_datalake
    extrair_sql >> carregar_sql_datalake

    # Data Warehouse
    [carregar_csv_datalake, carregar_sql_datalake] >> carregar_warehouse