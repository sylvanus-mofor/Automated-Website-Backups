# This file defines input variables for the IAM module.

variable "project_name" {
  description = "The unique project name from the root module, used for naming IAM resources."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to IAM resources where applicable (e.g., policies)."
  type        = map(string)
  default     = {} # Default to empty if no tags are passed
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket this IAM user/policy will be granted access to."
  type        = string
}