#!/usr/bin/env python3
"""Module for working with Redis to cache data."""
import redis
import uuid
from typing import Union


class Cache:
    """Cache class to store data in Redis."""

    def __init__(self):
        """Initialize the Redis client and flush the database."""
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Store the given data in Redis and return the generated key.

        Args:
            data (Union[str, bytes, int, float]): Data to be stored in Redis.

        Returns:
            str: The generated key for the stored data.
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key
