resource "github_repository" "repository" {
  name        = var.project_name
  description = var.project_description
  visibility  = "private"
}
