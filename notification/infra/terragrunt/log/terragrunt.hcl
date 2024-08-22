terraform {
  source = "${get_parent_terragrunt_dir()}/infra/terraform/log"
}

locals {
  log_name    = "python-cloudwatch-example-notification"
  common_tags = {
    environment = "development"
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {
  log_name    = local.log_name
  common_tags = local.common_tags
}
