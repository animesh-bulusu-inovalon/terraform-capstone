variable "infra_bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  type        = string
  default     = "animeshbulusu-infrastatefiles-apr2025-02"
}

variable "region" {
  description = "The AWS region where the S3 bucket will be created"
  type        = string
  default     = "eu-north-1"
}