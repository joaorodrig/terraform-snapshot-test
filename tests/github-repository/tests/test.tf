# Example to illustrate how to build optionality to static refs
module "stack_test_static_variable" {
  source = "../"

  # CI/CD variables
  github_access_token = var.github_access_token

  # Business variables
  project_name        = "test-repository"
  project_description = "mock repository for snapshot testing"
}
