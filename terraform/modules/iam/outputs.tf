output "dev_user_access_key" {
  description = "Dev user access key ID"
  value       = aws_iam_access_key.dev_view.id
}

output "dev_user_secret_key" {
  description = "Dev user secret access key"
  value       = aws_iam_access_key.dev_view.secret
  sensitive   = true
}

output "dev_user_password" {
  description = "Dev user console password"
  value       = aws_iam_user_login_profile.dev_view.password
  sensitive   = true
}