# Example to illustrate how to build optionality to static refs
module "stack_test_static_variable" {
  source = "../"

  # CI/CD variables
  gitlab_access_token = var.gitlab_access_token

  # Business variables
  project_name        = "test-repository"
  project_description = "mock repository for snapshot testing"

  static_group_id          = "116923234" # https://gitlab.com/terraform-snapshot-testing
  reference_group_path     = null
  gitlab_remote_state_keys = {}
}

# Example to illustrate how to build optionality to variable refs
module "stack_test_reference_variable" {
  source = "../"

  # CI/CD variables
  gitlab_access_token = var.gitlab_access_token

  # Business variables
  project_name        = "test-repository"
  project_description = "mock repository for snapshot testing"

  static_group_id          = null
  reference_group_path     = "terraform-snapshot-testing"
  gitlab_remote_state_keys = {}
}


# Example to illustrate how to build optionality to variable refs
# This would fail because the remote state is fictional
# module "stack_test_remote_reference_variable" {
#   source = "../"

#   # CI/CD variables
#   gitlab_access_token = var.gitlab_access_token

#   # Business variables
#   project_name        = "test-repository"
#   project_description = "mock repository for snapshot testing"

#   static_group_id      = null
#   reference_group_path = null
#   gitlab_remote_state_keys = {
#     gitlab_group_id = "./terraform-snapshot-testing.tfstate"
#   }
# }
