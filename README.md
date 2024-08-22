# Python CloudWatch Example

This project is an example of how to use some features of the AWS CloudWatch service.

- [Python CloudWatch Example](#python-cloudwatch-example)
  - [Requirements](#requirements)
  - [Getting Started](#getting-started)


## Requirements

- Node.js v20.8.1 / NPM 10.1.0
- Python 3.12.4 / Pipenv 2024.0.1
- Terraform v1.9.5 / Terragrunt v0.66.9
- AWS Credentials with permissions to create required infrastructure
- Task v3.29.1 (https://taskfile.dev/installation/)
- Linux/MacOS (On Windows use WLS 2 :stuck_out_tongue:)

## Getting Started

First, create a .env file with the following variables:

```shell
AWS_DEFAULT_REGION=us-west-2
AWS_REGION=us-west-2
AWS_ACCESS_KEY_ID=NLFKYEUZCWSMQJXPTRDH
AWS_SECRET_ACCESS_KEY=JWnE[Sg9/v?K2C.MX.+hQGfH4R7eZ6A@YrkPJy:N
AWS_ACCOUNT_ID=123456789012
CLOUDWATCH_LOG_GROUP_NAME=python-cloudwatch-example
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/DBXPAKMGL/QXTMZRWCFAV/uSdrVjTWzXhnxRMbfHptqPBN
```

> [!IMPORTANT] 
> You must replace these values

Create a virtual environment:

```shell
pipenv shell
```

Now run the task command:

```shell
task
```

> [!IMPORTANT]
> If you want to generate more logs to trigger the notification, run `task python:run`

Finally, to destroy all infrastructure, run the `task destroy` command:

```shell
task destroy
```

>[!TIP]
> You can run all tasks separately. Run `task --list-all` to view the complete list of tasks.