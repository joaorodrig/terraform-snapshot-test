terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}

provider "github" {
  token = var.github_access_token
}

variable "github_access_token" {
  type      = string
  sensitive = true
}
