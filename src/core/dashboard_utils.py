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
