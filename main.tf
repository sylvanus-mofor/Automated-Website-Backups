locals {
  # Base name used for resources, derived from the project_name variable
  base_name = var.project_name

  # Standard tags to apply to resources.
  # Merges the input tags with default project-specific tags.
  common_tags = merge(
    var.tags,
    {
      "Project" = local.base_name
      "ManagedBy" = "Terraform"
    }
  )
}

# --- Module Calls ---

# Call the S3 module to create the bucket.
module "s3" {
  source = "./s3"

  # Pass required variables to the S3 module
  project_name   = var.project_name        # Pass the root project name
  tags           = local.common_tags       # Pass the merged common tags
  force_destroy  = var.s3_force_destroy    # Pass the force_destroy flag
}

# Call the IAM module to create the user, policy, and access key.
# This module requires the S3 bucket ARN from the S3 module outputs to scope the policy.
module "iam" {
  source = "./iam"

  # Pass required variables to the IAM module
  project_name = var.project_name        # Pass the root project name
  tags         = local.common_tags       # Pass the merged common tags

  # Pass the S3 bucket ARN from the S3 module's output
  bucket_arn   = module.s3.bucket_arn
}

# --- Outputs ---

# Define root outputs to easily retrieve key information after deployment.

output "s3_bucket_name" {
  description = "The name of the created S3 bucket."
  # Reference the bucket_name output from the S3 module
  value = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "The ARN of the created S3 bucket."
  # Reference the bucket_arn output from the S3 module
  value = module.s3.bucket_arn
}

output "iam_user_name" {
  description = "The name of the created IAM user."
  # Reference the user_name output from the IAM module
  value = module.iam.user_name
}

output "iam_user_access_key_id" {
  description = "The Access Key ID for the created IAM user."
  # Reference the access_key_id output from the IAM module
  value = module.iam.access_key_id
  sensitive = true # Mark this output as sensitive
}

output "iam_user_secret_access_key" {
  description = "The Secret Access Key for the created IAM user."
  # Reference the secret_access_key output from the IAM module
  value = module.iam.secret_access_key
  sensitive = true # Mark this output as sensitive
}

# Note: sensitive outputs are masked in standard Terraform console output.
# Use 'terraform output -raw <output_name>' to see the actual value.