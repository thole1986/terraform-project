output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.primary_instance.db_name
}

output "primary_db_address" {
  description = "The hostname of the RDS primary instance"
  value       = aws_db_instance.primary_instance.address
}

output "replica_db_address" {
  description = "The hostname of the RDS replica instance"
  value       = aws_db_instance.replica.address
}

output "connect_to_database" {
  description = "Command to connect to database from EC2"
  value       = "mysql --host=${aws_db_instance.primary_instance.address} --user=${var.db_username} -p"
}
