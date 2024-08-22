locals {
  common_tags           = {
    environment = "development"
  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/terraform/cloudwatch/logs"
}

inputs = {
  name                    = get_env("CLOUDWATCH_LOG_GROUP_NAME")
  retention_in_days       = 30
  metrics_namespace       = "/python-cloudwatch-example"
  metrics_filter = [
    {
      name      = "error_on_main_count"
      pattern   = "{ ( $.level = \"ERROR\" ) && ( $.logger_name = \"main\" ) }"
    }
  ]
  tags                    = local.common_tags
}
