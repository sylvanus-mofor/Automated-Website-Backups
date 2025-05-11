# This file defines output values for the IAM module.

# Output the Access Key ID.
output "access_key_id" {
  description = "The Access Key ID for the IAM user."
  # Reference the access key resource by its updated logical name 'project_user_access_key'
  value = aws_iam_access_key.project_user_access_key.id
  sensitive = true # Mark this output as sensitive
}

# Output the Secret Access Key.
output "secret_access_key" {
  description = "The Secret Access Key for the IAM user."
  # Reference the access key resource by its updated logical name 'project_user_access_key'
  value = aws_iam_access_key.project_user_access_key.secret
  sensitive = true # Mark this output as sensitive
}

# Output the IAM User Name (useful for reference)
output "user_name" {
  description = "The name of the created IAM user."
  # Reference the user resource by its updated logical name 'project_user'
  value       = aws_iam_user.project_user.name
}