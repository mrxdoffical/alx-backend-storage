#!/usr/bin/env python3
"""Module for caching and tracking web page accesses."""
import redis
import requests
from typing import Callable
import functools

# Connect to the Redis server
r = redis.Redis()


def count_calls(method: Callable) -> Callable:
    """Decorator to count how many times a URL was accessed."""

    @functools.wraps(method)
    def wrapper(url: str) -> str:
        """Wrap the original method to count URL accesses."""
        r.incr(f"count:{url}")
        return method(url)

    return wrapper


@count_calls
def get_page(url: str) -> str:
    """
    Retrieve the HTML content of a URL and cache it for 10 seconds.

    Args:
        url (str): The URL to retrieve.

    Returns:
        str: The HTML content of the URL.
    """
    cached_page = r.get(f"cached:{url}")
    if cached_page:
        return cached_page.decode("utf-8")

    response = requests.get(url)
    html_content = response.text
    r.setex(f"cached:{url}", 10, html_content)
    return html_content


if __name__ == "__main__":
    test_url = "http://slowwly.robertomurray.co.uk"
    print(get_page(test_url))
    print(get_page(test_url))  # This should use the cached version
    print(f"Access count: {r.get(f'count:{test_url}').decode('utf-8')}")
