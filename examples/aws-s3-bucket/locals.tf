locals {
  # 1. Try to read from a remote state reference if key exists
  # 2. If we're passing a reference, do a data lookup
  # 3. Otherwise read a statically passed role arn
  reader_role_arn = try(
    data.terraform_remote_state.state["bucket_reader_role"].outputs.role_arn,
    var.reference_reader_role_name == null ? var.static_reader_role_arn : data.aws_iam_role.reader[0].arn
  )
}
