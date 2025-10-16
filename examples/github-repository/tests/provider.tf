terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 17.5"
    }
  }
}

provider "github" {
  token = var.github_access_token
}

variable "github_access_token" {
  type = string
}
