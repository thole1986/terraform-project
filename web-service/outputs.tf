output "instance_ids" {
  value = module.instances.instance_ids
}

output "connect_to_database" {
  value       = module.rds.connect_to_database
}

output "primary_db_address" {
  value = module.rds.primary_db_address
}

output "replica_db_address" {
  value = module.rds.replica_db_address
}