# This script creates an S3 bucket and enables versioning on it. This is not needed as the bucket is created during initialization layer. 
aws s3 mb s3://mybucket
aws s3api put-bucket-versioning --bucket mybucket --versioning-configuration Status=Enabled