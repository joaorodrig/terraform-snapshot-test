terraform {
  backend "s3" {}
}

# Default AWS Region
variable "aws_default_region" {
  type = string
}

# Target Account Role variables
variable "target_account_id" {
  type = string
}

variable "deployment_role" {
  type = string
}

# Remote State S3 Bucket
variable "backend_config_bucket" {
  type    = string
  default = ""
}

variable "backend_config_region" {
  type    = string
  default = ""
}

# Default tags
variable "tags" {
  type = object({
    owner       = string
    environment = string
    cost_center = string
  })
}

# Deployment account
data "aws_caller_identity" "deployment_account" {}

# Deployment account
provider "aws" {
  region = var.aws_default_region
}
