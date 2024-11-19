import logging

import pandas as pd
import requests


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
