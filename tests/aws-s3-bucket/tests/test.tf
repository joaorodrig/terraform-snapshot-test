module "stack_test_static_variable" {
  source = "../"

  # CI/CD variables
  deployment_role       = ""
  target_account_id     = ""
  aws_default_region    = "eu-west-1"
  backend_config_bucket = ""
  backend_config_region = ""

  # Business variables
  bucket_name                = "jack_in_the_box"
  static_reader_role_arn     = "arn:aws:iam::111111111111:role/lucille"
  reference_reader_role_name = null
  remote_state_keys          = {}

  # Tags
  tags = {
    owner       = "frank zappa"
    environment = "joe's garage"
    cost_center = "1979"
  }
}

# Example to illustrate how to build optionality to variable refs
# This would fail because referenced role (i.e. data call) does not exist
# module "stack_test_reference_variable" {
#   source = "../"

#   # CI/CD variables
#   deployment_role       = ""
#   target_account_id     = ""
#   aws_default_region    = "eu-west-1"
#   backend_config_bucket = ""
#   backend_config_region = ""

#   # Business variables
#   bucket_name                = "jack_in_the_box"
#   static_reader_role_arn     = null
#   reference_reader_role_name = "central_scrutinizer"
#   remote_state_keys          = {}

#   # Tags
#   tags = {
#     owner       = "frank zappa"
#     environment = "joe's garage"
#     cost_center = "1979"
#   }
# }

# Example to illustrate how to build optionality to variable refs
# This would fail because the remote state bucket is fictional
# module "stack_test_remote_reference_variable" {
#   source = "../"

#   # CI/CD variables
#   deployment_role       = ""
#   target_account_id     = ""
#   aws_default_region    = "eu-west-1"
#   backend_config_bucket = "lron_hoover"
#   backend_config_region = "eu-west-1"

#   # Business variables
#   bucket_name                = "jack_in_the_box"
#   static_reader_role_arn     = null
#   reference_reader_role_name = null

#   remote_state_keys = {
#     bucket_reader_role = "path/to/stack/sy_borg.tfstate"
#   }

#   # Tags
#   tags = {
#     owner       = "frank zappa"
#     environment = "joe's garage"
#     cost_center = "1979"
#   }
# }
