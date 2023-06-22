locals {
  public_subnet_ids = data.terraform_remote_state.networking.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.networking.outputs.private_subnet_ids
  vpc_id = data.terraform_remote_state.networking.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.networking.outputs.vpc_cidr_block
  public_security_group_id = data.terraform_remote_state.networking.outputs.public_security_group_id
}


module "instances" {
  source = "./modules/instances"

  tags_name     = var.tags_name
  servers       = var.servers
  instance_type = var.instance_type
  subnet_id     = local.public_subnet_ids
  public_security_group_id = local.public_security_group_id
}

module "alb" {
  source = "./modules/alb"

  vpc_id = local.vpc_id
  public_subnets = local.public_subnet_ids
  instance_ids = module.instances.instance_ids
}

#module "rds" {
#  source = "./modules/rds"
#
#  vpc_id = local.vpc_id
#  private_subnet_ids = local.private_subnet_ids
#  db_name     = var.db_name
#  db_username = var.db_username
#  db_password = var.db_password
#}


