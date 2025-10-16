# Import state file from another terraform stack
variable "gitlab_remote_state_keys" {
  type    = map(string)
  default = {}
}

data "terraform_remote_state" "gitlab_remote_state" {
  for_each = var.gitlab_remote_state_keys
  backend  = "local"
  config = {
    path = each.value
  }
}
