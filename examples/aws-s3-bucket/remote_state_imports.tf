# Import state file from another terraform stack
variable "remote_state_keys" {
  type    = map(string)
  default = {}
}

data "terraform_remote_state" "state" {
  for_each = var.remote_state_keys
  backend  = "s3"
  config = {
    bucket = var.backend_config_bucket
    region = var.backend_config_region
    key    = each.value
  }
}
