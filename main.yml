provider "aws" {
  region = "ap-south-1"
  access_key = "########################"
  secret_key = "################################"
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source          = "./ec2"
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.subnet_id
  key_name        = var.key_name
}

module "eip" {
  source          = "./eip"
  instance_id     = module.ec2.instance_id
}

module "ebs" {
  source          = "./ebs"
  availability_zone = var.availability_zone
  instance_id     = module.ec2.instance_id
}

module "backup" {
  source          = "./backup"
  volume_id       = module.ebs.volume_id
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
