// This file 
//    creates the S3 bucket used for storing Terraform state files.
//    defines an IAM policy granting minimal permissions for Terraform to access the S3 backend and lockfiles.

resource "aws_s3_bucket" "terraform_state" {
  provider = aws
  bucket   = var.infra_bucket_name

  lifecycle {
    prevent_destroy = true // Prevent accidental deletion of the bucket
  }
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

  // Block all public access to the bucket for security
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "_01_tf_init" {
  bucket = aws_s3_bucket.terraform_state.id
  key    = "01-terraform-init/" // Folder placeholder for init layer state files
}

resource "aws_s3_object" "_02_networking" {
  bucket = aws_s3_bucket.terraform_state.id
  key    = "02-networking/" // Folder placeholder for networking layer state files
}

resource "aws_s3_object" "_03_load_balancer" {
  bucket = aws_s3_bucket.terraform_state.id
  key    = "03-load-balancer/" // Folder placeholder for load balancer layer state files
}

resource "aws_s3_object" "_04_instances" {
  bucket = aws_s3_bucket.terraform_state.id
  key    = "04-instances/" // Folder placeholder for compute layer state files
}
