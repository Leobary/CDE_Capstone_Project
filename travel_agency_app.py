import logging

import awswrangler as wr
import boto3
import pandas as pd
import requests
from airflow.models import Variable


def get_data():
    """
        A function to extract data from the Country API provided
        and build a pandas dataframe.
        The 'src_url' is the base url for the API
    """

    src_url = "https://restcountries.com/v3.1/all"
    response = requests.get(src_url)
    logging.info("Fetching data ...")
    if response.status_code == 200:
        src_data = response.json()
    src_data_df = pd.DataFrame(src_data)
    logging.info(f"Dataframe created with {src_data_df.shape[0]}\
                              records and {src_data_df.shape[1]} columns")
    return src_data_df


# Establish connection with AWS
def aws_session():
    session = boto3.Session(
            aws_access_key_id=Variable.get('aws_access_key'),
            aws_secret_access_key=Variable.get('aws_secret_key'),
            region_name="eu-north-1"
    )
    return session


def extract_to_s3():
    """
        A function to load the extracted data from the API to the
        data lake (s3).
        Variable:
            df: The dataframe from get_data().
            path: s3 path to load the data into.
    """

    logging.info("Extracting data to s3 bucket ...")
    wr.s3.to_parquet(
        df=get_data(),
        path='s3://leo-cde-project/raw_data',
        boto3_session=aws_session(),
        dataset=True,
        mode='overwrite_partitions',
        schema_evolution=True
    )
    return ("Data successfully written to the s3 bucket")
