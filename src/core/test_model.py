import os
import logging

logger = logging.getLogger(__name__)


def sort_request(input_path, output_format="json"):
    """Transform input file to the specified output format."""
    if not os.path.exists(input_path):
        logger.error(f"File not found: {input_path}")
        return None

    logger.info(f"Processing {input_path} -> {output_format}")

    result = []
    with open(input_path, "r") as f:
        for line in f:
            result.append(line.strip())

    return {
        "format": output_format,
        "count": len(result),
        "items": result,
    }
