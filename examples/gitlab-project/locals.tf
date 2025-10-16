locals {
  # 1. Try to read from a remote state reference if key exists
  # 2. If we're passing a reference, do a data lookup
  # 3. Otherwise read a statically passed role arn
  gitlab_group_id = try(
    data.terraform_remote_state.gitlab_remote_state["gitlab_group_id"].outputs.group_id,
    var.reference_group_path == null ? var.static_group_id : data.gitlab_group.group[0].id
  )
}
