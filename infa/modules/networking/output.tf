output "vpc" {
  value = aws_vpc.vpc
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.vpc.cidr_block, null)
}

output "public_subnet_cidr_list_ipv4" {
  value       = aws_subnet.public_subnet.*.cidr_block
  description = "CIDR blocks of the created public subnets IPV4"
}

output "private_subnet_cidr_list_ipv4" {
  value       = aws_subnet.private_subnet.*.cidr_block
  description = "CIDR blocks of the created private subnets IPV4"
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "arn_public_subnet" {
  value = aws_subnet.public_subnet[*].arn
}

output "public_security_group_id" {
  value = aws_security_group.public_security.id
}

output "elastic_ip" {
  value = aws_eip.elastic_ip.public_ip
}
