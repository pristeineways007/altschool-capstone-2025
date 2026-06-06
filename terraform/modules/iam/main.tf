# Developer IAM User
resource "aws_iam_user" "dev_view" {
  name = "bedrock-dev-view"

  tags = {
    Project     = "karatu-2025-capstone"
    Environment = var.environment
  }
}

# Attach ReadOnlyAccess to dev user
resource "aws_iam_user_policy_attachment" "dev_readonly" {
  user       = aws_iam_user.dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Allow dev user to upload to assets bucket
resource "aws_iam_user_policy" "dev_s3_put" {
  name = "bedrock-dev-s3-put"
  user = aws_iam_user.dev_view.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${var.assets_bucket_name}/*"
      }
    ]
  })
}

# Console access for dev user
resource "aws_iam_user_login_profile" "dev_view" {
  user = aws_iam_user.dev_view.name
}

# Access keys for dev user
resource "aws_iam_access_key" "dev_view" {
  user = aws_iam_user.dev_view.name
}