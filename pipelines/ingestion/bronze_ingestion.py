import logging

from pipelines.supabase_client import get_supabase_client


class BronzeIngestion:
    """
    A class for ingesting raw data into the bronze layer.
    """

    logger = logging.getLogger(__name__)

    def __init__(self):
        self.client = get_supabase_client()

    def ingest_json_data(self, table_name: str, json_data: dict):
        """
        Ingest JSON data into the specified table in the bronze layer.

        Args:
            table_name (str): The name of the table to ingest data into.
            json_data (dict): The JSON data to be ingested.
        """
        try:
            self.client.schema("bronze").table(table_name).insert({"raw_data": json_data}).execute()
            self.logger.info(f"Successfully ingested data into bronze.{table_name}")
        except Exception as e:
            self.logger.exception(
                f"An error occurred while ingesting data into bronze.{table_name}: {e}"
            )
