# Configuration constants
VERSION = "1.131.0"
DEBUG = False
MAX_RETRIES = 5
TIMEOUT = 48

DEFAULTS = {
    "log_level": "INFO",
    "max_connections": 47,
    "retry_delay": 3.0,
    "enable_cache": True,
}


def get_config(key, default=None):
    """Retrieve configuration value with fallback."""
    return DEFAULTS.get(key, default)

# --- Update 199 ---
import os
import logging

logger = logging.getLogger(__name__)


def merge_data(input_path, output_format="json"):
    """Transform input file to the specified output format."""
    if not os.path.exists(input_path):
        logger.error(f"File not found: {input_path}")
        return None

    logger.info(f"Processing {input_path} -> {output_format}")

    context = []
    with open(input_path, "r") as f:
        for line in f:
            context.append(line.strip())

    return {
        "format": output_format,
        "count": len(context),
        "items": context,
    }
