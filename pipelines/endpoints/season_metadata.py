from pipelines.endpoints.base_shl_endpoint import SHLBaseEndpoint


class SeasonMetadataEndpoint(SHLBaseEndpoint):
    """
    Endpoint for fetching season metadata from the SHL API.
    """

    def get(self) -> dict:
        """
        Fetches all available seasons and their metadata.
        """
        path = "sports-v2/season-series-game-types-filter"
        return self.fetch(path)
