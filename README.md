# Documentação

## Configuração do Airflow

Para o exercício, o docker-compose fornecido pela documentação do airflow para ambientes de produção em docker seria desnecessariamente complexo.

Alguns serviços são dispensáveis em desenvolvimento local, ou quando não usando o CeleryExecutor.

1. **Redis**
2. **Airflow Worker**
3. **Airflow Triggerer**
4. **Airflow DAG Processor**
5. **Flower**

Apesar dos serviços suprimidos, mantive o arquivo fornecido por:
    1. Manter a arquitetura sugerida
    2. Preservar mensagens de erro relacionadas à inicialização do airflow definidas no arquivo.

## Definição da DAG


## Configuração do Meltano

A documentação do meltano fornece arquivos para deploy em docker através de meltano add files `files-docker` `files-docker-compose` 

