# This file defines the AWS S3 bucket resource.

# Create the S3 bucket resource
# Changed logical name from 'this' to 'project_bucket'
resource "aws_s3_bucket" "project_bucket" {
  # Derive the bucket name from the project_name input variable.
  # Note: S3 bucket names must be globally unique and follow specific rules.
  # Appending a unique identifier (like account ID or random string) is
  # recommended for production to ensure uniqueness, but we'll use
  # project_name directly as requested.
  bucket = "${var.project_name}-bucket"

  # Option to force destroy the bucket and its contents.
  # This should be 'false' in production environments.
  force_destroy = var.force_destroy

  # Apply tags passed from the root module.
  tags = var.tags

  # Best practice: Configure common S3 settings like versioning, server-side encryption,
  # public access block, etc. Here are some basic production-ready examples:

  # Prevent public access by default
  # resource "aws_s3_bucket_public_access_block" "project_bucket_public_access_block" {
  #   bucket = aws_s3_bucket.project_bucket.id # Updated reference
  #   block_public_acls       = true
  #   block_public_policy     = true
  #   ignore_public_acls      = true
  #   restrict_public_buckets = true
  # }

  # Enable default server-side encryption
  # resource "aws_s3_bucket_server_side_encryption_configuration" "project_bucket_server_side_encryption" {
  #   bucket = aws_s3_bucket.project_bucket.id # Updated reference
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "AES256"
  #     }
  #   }
  # }

  # Enable versioning (recommended for data protection)
  # resource "aws_s3_bucket_versioning" "project_bucket_versioning" {
  #   bucket = aws_s3_bucket.project_bucket.id # Updated reference
  #   versioning_configuration {
  #     status = "Enabled"
  #   }
  # }
}