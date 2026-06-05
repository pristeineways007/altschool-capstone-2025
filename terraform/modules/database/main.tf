# Security Group for RDS
resource "aws_security_group" "rds" {
  name        = "project-bedrock-rds-sg"
  description = "Security group for RDS instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.eks_security_group_id]
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.eks_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project     = "karatu-2025-capstone"
    Environment = var.environment
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "project-bedrock-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Project     = "karatu-2025-capstone"
    Environment = var.environment
  }
}

# RDS MySQL
resource "aws_db_instance" "mysql" {
  identifier        = "project-bedrock-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "catalog"
  username = "admin"
  password = random_password.mysql.result

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  multi_az            = false

  tags = {
    Project     = "karatu-2025-capstone"
    Environment = var.environment
  }
}

# RDS PostgreSQL
resource "aws_db_instance" "postgresql" {
  identifier        = "project-bedrock-postgresql"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "orders"
  username = "admin"
  password = random_password.postgresql.result

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  multi_az            = false

  tags = {
    Project     = "karatu-2025-capstone"
    Environment = var.environment
  }
}

# Random passwords
resource "random_password" "mysql" {
  length  = 16
  special = false
}

resource "random_password" "postgresql" {
  length  = 16
  special = false
}

# Store passwords in Secrets Manager
resource "aws_secretsmanager_secret" "mysql" {
  name = "project-bedrock/mysql"
  tags = {
    Project     = "karatu-2025-capstone"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "mysql" {
  secret_id = aws_secretsmanager_secret.mysql.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.mysql.result
    host     = aws_db_instance.mysql.address
    port     = 3306
    dbname   = "catalog"
  })
}

resource "aws_secretsmanager_secret" "postgresql" {
  name = "project-bedrock/postgresql"
  tags = {
    Project     = "karatu-2025-capstone"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "postgresql" {
  secret_id = aws_secretsmanager_secret.postgresql.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.postgresql.result
    host     = aws_db_instance.postgresql.address
    port     = 5432
    dbname   = "orders"
  })
}

# DynamoDB table for cart
resource "aws_dynamodb_table" "cart" {
  name         = "project-bedrock-cart"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Project     = "karatu-2025-capstone"
    Environment = var.environment
  }
}