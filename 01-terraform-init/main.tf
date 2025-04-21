resource "aws_s3_bucket" "terraform_state" {
  provider = aws
  bucket   = "animeshbulusu-infrastatefiles-apr2025-02"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_object" "_01_tf_init" {
  bucket = aws_s3_bucket.terraform_state.id
  key    = "01-terraform-init/"
}

resource "aws_iam_policy" "tf_s3_backend_policy" {
  name        = "terraform-s3-backend-policy-v4"
  path        = "/"
  description = "IAM policy for Terraform S3 backend access with explicit lockfile permissions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:GetObject", "s3:PutObject"]
        Resource = [
          "arn:aws:s3:::animeshbulusu-infrastatefiles-apr2025-02/01-terraform-init/01-terraform-init.tfstate"
        ]
      },
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
        Resource = [
          "arn:aws:s3:::animeshbulusu-infrastatefiles-apr2025-02/01-terraform-init/01-terraform-init.tfstate.tflock"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "terraform_state_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}