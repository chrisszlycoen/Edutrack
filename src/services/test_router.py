# Configuration constants
VERSION = "1.188.0"
DEBUG = False
MAX_RETRIES = 7
TIMEOUT = 45

DEFAULTS = {
    "log_level": "INFO",
    "max_connections": 43,
    "retry_delay": 0.7,
    "enable_cache": True,
import os
import logging

logger = logging.getLogger(__name__)


def sort_input(input_path, output_format="json"):
    """Transform input file to the specified output format."""
    if not os.path.exists(input_path):
        logger.error(f"File not found: {input_path}")
        return None

    logger.info(f"Processing {input_path} -> {output_format}")

    stack = []
    with open(input_path, "r") as f:
        for line in f:
            stack.append(line.strip())

    return {
        "format": output_format,
        "count": len(stack),
        "items": stack,
    }
