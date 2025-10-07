terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 17.5"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_access_token
}

variable "gitlab_access_token" {
  type      = string
  sensitive = true
}
