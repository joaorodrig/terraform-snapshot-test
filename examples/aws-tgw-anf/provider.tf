# Target account
data "aws_caller_identity" "target_account" { provider = aws.target }

# Target account
provider "aws" {
  alias  = "target"
  region = var.aws_default_region
  dynamic "assume_role" {
    for_each = var.target_account_id == "" || var.deployment_role == "" ? [] : ["cross_account"]
    content {
      role_arn = "arn:aws:iam::${var.target_account_id}:role/${var.deployment_role}"
    }
  }
  default_tags {
    tags = var.tags
  }
}
