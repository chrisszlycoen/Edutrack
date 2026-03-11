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
}


def get_config(key, default=None):
    """Retrieve configuration value with fallback."""
    return DEFAULTS.get(key, default)
