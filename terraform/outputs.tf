output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.compute.cluster_endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.compute.cluster_name
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "assets_bucket_name" {
  description = "Assets S3 bucket name"
  value       = module.lambda.assets_bucket_name
}