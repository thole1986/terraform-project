provider "aws" {
  region = "ap-southeast-1"
}

module "networking" {
  source = "./modules/networking"

  project           = var.project
  region            = var.region
  vpc_cidr_block    = var.vpc_cidr_block
  private_subnet    = var.private_subnet
  public_subnet     = var.public_subnet
  availability_zone = var.availability_zone
  tags_name         = var.tags_name
}
