import datetime

from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.snowflake.transfers.copy_into_snowflake import \
    CopyFromExternalStageToSnowflakeOperator
from utils.extract_raw_to_s3 import extract_to_s3
from utils.extract_trans_to_s3 import extract_transformed_to_s3

DAG_ID = 'travel_agency'

default_args = {
    'owner': 'cde_cohort_1',
    'start_date': datetime.datetime(2024, 11, 11),
    'retries': 1,
    'retry_delay': datetime.timedelta(seconds=5)
}


with DAG(
    DAG_ID,
    default_args=default_args,
    schedule_interval='0 0 * * *',
    catchup=False,
    default_view="graph",
    tags=["capstone project", "cde"]
) as dag:

    extract_raw_to_s3 = PythonOperator(
        task_id="extract_raw_to_s3",
        python_callable=extract_to_s3
    )

    extract_trans_data_to_s3 = PythonOperator(
        task_id="extract_trans_data_to_s3",
        python_callable=extract_transformed_to_s3
    )

    copy_data_into_snowflake = CopyFromExternalStageToSnowflakeOperator(
        task_id="copy_data_into_snowflake",
        snowflake_conn_id="snowflake_connect",
        stage="CDE_PRJ_S3_STAGE",
        table="STAGING_TABLE",
        file_format="PARQUET_FORMAT",
        schema="PROJECT",
        database="CDE_PROJECT_DB",
        autocommit=True,
        role="ACCOUNTADMIN"
    )


extract_raw_to_s3 >> extract_trans_data_to_s3 >> copy_data_into_snowflake
