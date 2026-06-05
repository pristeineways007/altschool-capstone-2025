variable "environment" {
  description = "Environment name"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "eks_security_group_id" {
  description = "EKS cluster security group ID"
  type        = string
}

variable "student_id" {
  description = "Student ID for unique bucket naming"
  type        = string
}