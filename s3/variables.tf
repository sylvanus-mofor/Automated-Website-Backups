# This file defines input variables for the S3 module.

variable "project_name" {
  description = "The unique project name from the root module, used for naming the bucket."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the S3 bucket."
  type        = map(string)
  default     = {} # Default to empty if no tags are passed
}

variable "force_destroy" {
  description = "Allows deleting the S3 bucket and all its objects. Use with extreme caution."
  type        = bool
  default     = false
}