variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "assets_bucket_name" {
  description = "Assets S3 bucket name"
  type        = string
}