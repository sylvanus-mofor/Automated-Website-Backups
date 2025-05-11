# This file configures the AWS provider for all resources managed by this configuration.

provider "aws" {
  # Use the region variable defined in variables.tf
  region = var.region
}