output "vpc_cidr_block" {
  value = module.networking.vpc_cidr_block
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "public_subnet_cidr_list_ipv4" {
  value = module.networking.public_subnet_cidr_list_ipv4
}

output "private_subnet_cidr_list_ipv4" {
  value = module.networking.private_subnet_cidr_list_ipv4
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "elastic_ip" {
  value = module.networking.elastic_ip
}

output "public_security_group_id" {
  value = module.networking.public_security_group_id
}