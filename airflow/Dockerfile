FROM apache/airflow:3.0.6

USER airflow

RUN python -m pip install --user pipx && \
    python -m pipx ensurepath

RUN python3 -m pipx install uv && \
    uv tool install meltano