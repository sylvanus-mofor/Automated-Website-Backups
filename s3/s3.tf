variable "project_name" {
  type        = string
  description = "Project name"
}

variable "bucket_name" {
  type        = string
  description = "Bucket name"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the s3 bucket"
  default = {
    Name = "project-name" 
    Freq = "Weekly"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags          = var.tags
}
output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}
output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}
output "bucket_name" {
  value = aws_s3_bucket.bucket.arn
}