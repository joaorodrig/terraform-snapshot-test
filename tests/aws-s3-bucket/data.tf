data "aws_iam_role" "reader" {
  count = var.reference_reader_role_name == null ? 0 : 1
  name  = var.reference_reader_role_name
}
