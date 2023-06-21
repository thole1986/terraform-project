output "aws_instances" {
    value = aws_instance.web
}

output "instance_ids" {
  value = [for inst in aws_instance.web: inst.id]
}