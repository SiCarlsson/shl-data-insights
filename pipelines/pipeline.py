from pipelines.endpoints.season_metadata import SeasonMetadataEndpoint
from pipelines.ingestion.bronze_ingestion import BronzeIngestion

if __name__ == "__main__":
    season_metadata = SeasonMetadataEndpoint().get()
    BronzeIngestion().ingest_json_data("shl_metadata", season_metadata)
