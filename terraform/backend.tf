terraform {
  backend "s3" {
    bucket = "project-bedrock-tfstate-victor"
    key    = "project-bedrock/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}