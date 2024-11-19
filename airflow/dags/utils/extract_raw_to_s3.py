import logging

import awswrangler as wr

from .aws_session import aws_session
from .get_data import get_data


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
