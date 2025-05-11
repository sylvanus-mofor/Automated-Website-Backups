# This file defines output values for the S3 module.

# Output the name (ID) of the created S3 bucket.
output "bucket_name" {
  description = "The name (ID) of the created S3 bucket."
  # Reference the bucket resource by its updated logical name 'project_bucket'
  value = aws_s3_bucket.project_bucket.id
}

# Output the ARN of the created S3 bucket.
output "bucket_arn" {
  description = "The ARN of the created S3 bucket."
  # Reference the bucket resource by its updated logical name 'project_bucket'
  value = aws_s3_bucket.project_bucket.arn
}