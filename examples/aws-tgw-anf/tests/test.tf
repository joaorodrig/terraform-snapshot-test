module "test_nonprod" {
  source = "../"

  # CI/CD variables
  deployment_role       = ""
  target_account_id     = ""
  aws_default_region    = "eu-west-1"
  backend_config_bucket = ""
  backend_config_region = ""

  # Business variables
  network_name   = "nonprod"
  anf_policy_arn = null

  # Tags
  tags = {
    owner       = "frank zappa"
    environment = "joe's garage - nonprod"
    cost_center = "1979"
  }
}

module "test_prod" {
  source = "../"

  # CI/CD variables
  deployment_role       = ""
  target_account_id     = ""
  aws_default_region    = "eu-west-1"
  backend_config_bucket = ""
  backend_config_region = ""

  # Business variables
  network_name   = "prod"
  anf_policy_arn = "arn:aws:network-firewall:eu-west-1:123456789012:firewall-policy/east-west-prod"

  # Tags
  tags = {
    owner       = "frank zappa"
    environment = "joe's garage - prod"
    cost_center = "1979"
  }
}
