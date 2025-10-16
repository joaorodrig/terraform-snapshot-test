locals {
  # 1. Try to read from a remote state reference if key exists
  # 3. Otherwise read a statically passed anf policy arn
  anf_policy_arn = try(
    data.terraform_remote_state.state["anf-east-west-euw1"].outputs.anf_policy_arn,
    var.anf_policy_arn
  )
}
