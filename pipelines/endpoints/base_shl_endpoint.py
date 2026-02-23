import logging

import httpx

logger = logging.getLogger(__name__)


class SHLBaseEndpoint:
    """
    A base class for SHL API endpoints.
    """

    BASE_URL = "https://www.shl.se/api/"

    def __init__(self, timeout: int = 10):
        self.timeout = timeout

    def fetch(self, path: str, params: dict = None) -> dict:
        """
        Fetches data from the SHL API for the given endpoint path.

        Args:
            path (str): The endpoint path to fetch data from.
            params (dict, optional): Query parameters to include in the request.

        Returns:
            dict: The JSON response from the API.
            
        Raises:
            httpx.HTTPStatusError: If the response status code indicates an error.
            httpx.RequestError: If there was an issue making the request.
        """
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
