# This file defines AWS IAM resources (user, policy, access key).

# Create an IAM user for programmatic access.
# Changed logical name from 'this' to 'project_user'
resource "aws_iam_user" "project_user" {
  # Derive the user name from the project_name input variable.
  name = "${var.project_name}-user"

  # Tags are not directly supported on IAM users via the primary 'tags' argument
  # but can sometimes be applied via other resources or specific providers.
  # Keeping the tags variable definition for consistency and potential future use on other resources.
}

# Create an IAM policy that grants permissions.
# Changed logical name from 'this' to 'project_policy'
resource "aws_iam_policy" "project_policy" {
  # Derive the policy name from the project_name input variable.
  name        = "${var.project_name}-policy"
  description = "Policy to allow get, put, and list permissions on the specific S3 bucket."

  # Apply tags to the policy resource.
  tags = var.tags

  # Define the policy document.
  # This policy now specifically targets the S3 bucket identified by its ARN.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",    # Allows downloading objects
          "s3:PutObject",    # Allows uploading objects
          "s3:ListBucket"    # Allows listing objects in the bucket
          # Consider adding s3:DeleteObject if needed
        ]
        # Restrict permissions to the specific bucket and its contents using the ARN
        Resource = [
          var.bucket_arn,        # Permission on the bucket itself (for ListBucket)
          "${var.bucket_arn}/*"  # Permission on objects within the bucket (for GetObject, PutObject)
        ]
      },
      # Potentially add statements for other necessary permissions if required
    ]
  })
}

# Attach the policy to the user.
# Changed logical name from 'this' to 'project_user_policy_attachment'
resource "aws_iam_user_policy_attachment" "project_user_policy_attachment" {
  # Reference the created user by its updated logical name 'project_user'
  user       = aws_iam_user.project_user.name
  # Reference the created policy by its updated logical name 'project_policy'
  policy_arn = aws_iam_policy.project_policy.arn
}

# Create an access key for the IAM user.
# Changed logical name from 'this' to 'project_user_access_key'
resource "aws_iam_access_key" "project_user_access_key" {
  # Reference the created user by its updated logical name 'project_user'
  user = aws_iam_user.project_user.name
}