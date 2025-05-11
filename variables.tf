# This file defines input variables for the root module configuration.

# --- General Variables ---

variable "project_name" {
  description = "A unique name for the project. This will be used as a base for resource names (e.g., S3 bucket, IAM user). Terraform will prompt for this if not provided."
  type        = string
  # No default here makes it a required variable, prompting the user if not set
}

variable "region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "us-east-1" # Set a common default, can be overridden
}

variable "tags" {
  description = "A map of tags to apply to resources where applicable."
  type        = map(string)
  default     = {} # Start with no default tags
}

# --- S3 Module Variables ---

variable "s3_force_destroy" {
  description = "Allows deleting the S3 bucket and all its objects by setting this to true. DANGER: This is for development/testing only. Set to false (default) for production."
  type        = bool
  default     = false
}

# --- IAM Module Variables ---

# No additional specific variables needed here currently,
# project_name and tags are passed from the root.
# The bucket_arn will be passed as an output from the S3 module.