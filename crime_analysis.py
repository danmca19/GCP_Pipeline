from google.cloud import bigquery
import csv
import io

def load_crime_data(event, context):
    """
    Função para carregar os dados de crime do Cloud Storage para o BigQuery.
    """
    bucket_name = event['bucket']
    file_name = event['name']

    if not file_name.endswith('.csv'):
        print(f"Arquivo ignorado: {file_name}")
        return

    project_id = "seu-projeto-id"
    dataset_id = "sua_base_de_dados"
    table_id = "crime_summary_bigquery"  # Nome da tabela no BigQuery
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)

    try:
        csv_data = blob.download_as_string().decode("utf-8")

        # Inicializa o cliente do BigQuery
        client = bigquery.Client(project=project_id)

        # Define o nome da tabela completa
        table_ref = client.dataset(dataset_id).table(table_id)

        # Detecta o schema automaticamente
        job_config = bigquery.LoadJobConfig(
            source_format=bigquery.SourceFormat.CSV,
            skip_leading_rows=1, # skip header row
            autodetect=True
        )

        # Carrega os dados
        load_job = client.load_table_from_string(
            csv_data,
            table_ref,
            job_config=job_config
        )
        load_job.result()  # Espera o job completar

        print(f"Arquivo {file_name} carregado para o BigQuery na tabela {project_id}.{dataset_id}.{table_id}")

    except Exception as e:
        print(f"Erro ao processar o arquivo {file_name}: {e}")