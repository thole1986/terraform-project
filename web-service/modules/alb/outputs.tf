output "data_aws_lb" {
  value = aws_lb_target_group.target_group
}

output "data_aws_lb_target_group" {
  value = aws_lb.alb
}

output "alb_dns_name" {
  value = "${aws_lb.alb.dns_name}"
}

output "alb_target_group_arn" {
  value = "${aws_lb.alb.arn}"
}