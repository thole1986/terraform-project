#  DB Security Group
resource "aws_security_group" "db_security_group" {
  name        = "db-security-group"
  description = "Security Group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL traffic from Web Servers"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-security-group"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [for prv_id in var.private_subnet_ids : prv_id]

  tags = {
    Name = "db-subnet-group"
  }
}

# RDS
resource "aws_db_instance" "primary_instance" {
  identifier              = var.identifier_primary
  allocated_storage       = var.db_allocated_storage
  db_name                 = var.db_name
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true  # if set to true => can destroy
  multi_az                = true
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.db_security_group.id]
  backup_retention_period = 7 # Backups are required in order to create a replica

  tags = {
    Name = "primary-instance"
  }
}

resource "aws_db_instance" "replica" {
  identifier                 = var.identifier_replica
  replicate_source_db        = aws_db_instance.primary_instance.id
  replica_mode               = "mounted"
  auto_minor_version_upgrade = false
  instance_class             = var.db_instance_class
  multi_az                   = true
  skip_final_snapshot        = true
  backup_retention_period    = 0 # disable

  tags = {
    Name = "replica-instance"
  }
}