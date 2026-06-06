variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "project-bedrock-cluster"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "project-bedrock-vpc"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "student_id" {
  description = "Student ID for unique bucket naming"
  type        = string
}