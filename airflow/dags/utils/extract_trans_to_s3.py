import logging

import awswrangler as wr

from .aws_session import aws_session
from .get_data import get_data
from .transform_cols import extract_country_info

raw_source_data = get_data()

# The extract_country_info() is used to extract the required columns
# from the raw data
transformed_df = raw_source_data.apply(extract_country_info,
                                       axis=1, result_type="expand")


def extract_transformed_to_s3():
    """
        A function to load the transformed data to the
        data lake (s3).
        Variable:
            df: The dataframe from transformed_df.
            path: s3 path to load the data into.
    """

    logging.info("Extracting data to s3 bucket ...")
    wr.s3.to_parquet(
        df=transformed_df,
        path='s3://leo-cde-project/transformed_data',
        boto3_session=aws_session(),
        dataset=True,
        mode='overwrite_partitions',
        schema_evolution=True
    )
    return ("Data successfully written to the s3 bucket")
