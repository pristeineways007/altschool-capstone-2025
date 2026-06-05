provider "aws" {
  region = var.region
}

module "networking" {
  source      = "./modules/networking"
  vpc_name    = var.vpc_name
  region      = var.region
  environment = var.environment
}

module "compute" {
  source             = "./modules/compute"
  cluster_name       = var.cluster_name
  region             = var.region
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  environment        = var.environment
}

module "database" {
  source                = "./modules/database"
  environment           = var.environment
  private_subnet_ids    = module.networking.private_subnet_ids
  vpc_id                = module.networking.vpc_id
  eks_security_group_id = module.compute.cluster_security_group_id
}

module "iam" {
  source             = "./modules/iam"
  environment        = var.environment
  cluster_name       = var.cluster_name
  assets_bucket_name = module.lambda.assets_bucket_name
}

module "lambda" {
  source      = "./modules/lambda"
  environment = var.environment
  student_id  = var.student_id
}