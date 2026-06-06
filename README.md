# Project Bedrock - AltSchool Capstone 2025

## Infrastructure
Built with Terraform on AWS EKS.

## Prerequisites
- AWS CLI configured
- kubectl installed
- Helm installed
- EKS cluster running

## Deploy Application

### Connect to EKS cluster
aws eks update-kubeconfig --region us-east-1 --name project-bedrock-cluster

### Deploy using Helm
helm upgrade --install retail-store ./k8s/retail-store \
  --namespace retail-app \
  --create-namespace \
  --values ./k8s/retail-store/values.yaml


## Infrastructure Pipeline
- Open a PR → triggers `terraform plan`
- Merge to main → triggers `terraform apply`

## App URL
http://k8s-retailap-retailst-17d19cf248-1179277769.us-east-1.elb.amazonaws.com