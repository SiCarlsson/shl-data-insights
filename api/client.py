import httpx
import logging


logger = logging.getLogger(__name__)


class SHLClient:
    """
    A client for interacting with the SHL Data API.
    """

    BASE_URL = "https://www.shl.se/api/"

    def __init__(self, timeout: int = 10):
        self.timeout = timeout

    def get(self, path: str, params: dict = None) -> dict:
        url = f"{self.BASE_URL}{path}"
        logger.info(f"Making GET request to {url} with params {params}")
        try:
            response = httpx.get(url, params=params, timeout=self.timeout)
            response.raise_for_status()
            logger.info(f"Received response: {response.status_code}")
            return response.json()
        except httpx.HTTPStatusError as e:
            logger.error(f"HTTP error {e.response.status_code} for {url}")
            raise
        except httpx.RequestError as e:
            logger.error(f"Request failed for {url}: {e}")
            raise
