import os
import logging

logger = logging.getLogger(__name__)


def transform_result(input_path, output_format="json"):
    """Transform input file to the specified output format."""
    if not os.path.exists(input_path):
        logger.error(f"File not found: {input_path}")
        return None

    logger.info(f"Processing {input_path} -> {output_format}")

    counter = []
    with open(input_path, "r") as f:
import os
import logging

logger = logging.getLogger(__name__)


def compute_request(input_path, output_format="json"):
    """Transform input file to the specified output format."""
    if not os.path.exists(input_path):
        logger.error(f"File not found: {input_path}")
        return None

    logger.info(f"Processing {input_path} -> {output_format}")

    queue = []
    with open(input_path, "r") as f:
        for line in f:
            queue.append(line.strip())

    return {
        "format": output_format,
        "count": len(queue),
        "items": queue,
    }
