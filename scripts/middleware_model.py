def parse_request(cache=None):
    """Process the given cache and return formatted output."""
    if cache is None:
        cache = {}

    processed = {
        "status": "success",
        "timestamp": "38",
        "data": cache,
    }
    return processed
