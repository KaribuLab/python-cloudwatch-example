import os
import boto3

AWS_REGION = os.getenv("AWS_REGION")

boto3_logs_client = boto3.client("logs", region_name=AWS_REGION)

config = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "default": {
            "format": "[%(levelname)s]: %(asctime)s - %(name)s (line:%(lineno)d) - %(message)s",
            "datefmt": "%Y-%m-%d %H:%M:%S",
        },
        "cloudwatch": {
            "()": "logging_commons.formatter.JsonFormatter",
            "format_dict": {
                "level": "levelname",
                "timestamp": "asctime",
                "logger_name": "name",
                "module": "module",
                "line": "lineno",
                "message": "message",
                "context": "mdc",
            },
        },
    },
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "formatter": "default",
            "stream": "ext://sys.stderr",
        },
        "watchtower": {
            "class": "watchtower.CloudWatchLogHandler",
            "formatter": "cloudwatch",
            "boto3_client": boto3_logs_client,
            "log_group_name": os.getenv("CLOUDWATCH_LOG_GROUP_NAME"),
            "level": "INFO",
            "log_stream_name": "{logger_name}-{strftime:%Y-%m-%d}",
            "use_queues": False,
            "create_log_group": False,
        },
    },
    "root": {
        "level": "INFO",
        "handlers": ["console"],
    },
    "loggers": {
        "main": {
            "level": "INFO",
            "handlers": ["console", "watchtower"],
            "propagate": False,
        },
    },
}
