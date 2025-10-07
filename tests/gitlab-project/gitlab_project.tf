resource "gitlab_project" "repository" {
  name                                             = var.project_name
  description                                      = var.project_description
  namespace_id                                     = local.gitlab_group_id
  request_access_enabled                           = false
  lfs_enabled                                      = true
  archive_on_destroy                               = false
  group_runners_enabled                            = true
  visibility_level                                 = "private"
  default_branch                                   = "main"
  approvals_before_merge                           = 2
  analytics_access_level                           = "private"
  ci_separated_caches                              = true
  only_allow_merge_if_all_discussions_are_resolved = true
  only_allow_merge_if_pipeline_succeeds            = true
  packages_enabled                                 = true
  public_jobs                                      = false
  merge_requests_enabled                           = true
}
