import os

from dotenv import load_dotenv
from supabase import Client, create_client

load_dotenv(dotenv_path=".env.production")


def get_supabase_client() -> Client:
    """
    Creates and returns a Supabase client using environment variables.

    Returns:
        Client: A Supabase client instance.
    """
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")
    return create_client(url, key)
