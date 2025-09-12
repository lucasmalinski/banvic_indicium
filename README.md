# Anotações

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


## Configuração do Meltano

A documentação do meltano fornece arquivos para deploy em docker através de meltano add files `files-docker` `files-docker-compose` 

### TAPS
 > Dois csv loaders (--inherit-from target-csv) para resolver a diferença de nomenclatura de ```<fonte de dados>```


## Definição da DAG
```
completar
```
## Notas gerais

> Containers docker em networks diferentes para simular contexto BANVIC -> INDICIUM

> banvic-network para linkar containers dockers (meltano poder ver o postgre do banvic)



### Passos p/ deploy / Instruções de uso 

0. Requirements 
- docker-buildx
  
1. Deploy do SERVIDOR BANVIC
``` 
cd postgres_banvic 
docker compose up -d
```

1. Deploy do SERVIDOR AIRFLOW
```
cd airflow
docker compose up -d
```

A DAG já está configurada de forma a iniciar e terminar a execução do container meltano, que fará a extração e o carregamento. A pipeline será executada diariamente às 4:35



