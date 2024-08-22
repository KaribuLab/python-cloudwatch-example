import logging
from logging.config import dictConfig
from uuid import uuid4
from logging_commons.utils import MDC
from loggin_config import config

dictConfig(config)

LOGGER = logging.getLogger("main")


def main():
    LOGGER.info("Starting the application")
    with MDC(process_id=str(uuid4())):
        LOGGER.info("Processing the request")
        LOGGER.error("An error occurred")


if __name__ == "__main__":
    main()
