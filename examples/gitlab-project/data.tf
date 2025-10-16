data "gitlab_group" "group" {
  count     = var.reference_group_path == null ? 0 : 1
  full_path = var.reference_group_path
}
