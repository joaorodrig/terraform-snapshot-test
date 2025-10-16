variable "bucket_name" {
  type = string
}

variable "static_reader_role_arn" {
  type    = string
  default = null
}

variable "reference_reader_role_name" {
  type    = string
  default = null
}
