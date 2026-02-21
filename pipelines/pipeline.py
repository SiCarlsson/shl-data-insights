from pipelines.endpoints.season_metadata import SeasonMetadataEndpoint

if __name__ == "__main__":
    season_metadata = SeasonMetadataEndpoint().get()
    print(season_metadata)
