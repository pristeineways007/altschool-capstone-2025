output "mysql_endpoint" {
  description = "MySQL RDS endpoint"
  value       = aws_db_instance.mysql.address
}

output "postgresql_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = aws_db_instance.postgresql.address
}

output "mysql_secret_arn" {
  description = "MySQL secret ARN"
  value       = aws_secretsmanager_secret.mysql.arn
}

output "postgresql_secret_arn" {
  description = "PostgreSQL secret ARN"
  value       = aws_secretsmanager_secret.postgresql.arn
}

output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = aws_dynamodb_table.cart.name
}