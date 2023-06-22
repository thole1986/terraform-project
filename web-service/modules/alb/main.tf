resource "aws_security_group" "alb_security_group" {
  name        = "alb-security-group"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
    # Environment = var.env
  }
}

resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [for i in var.public_subnets : i]
  ip_address_type    = "ipv4"
  enable_http2       = false

  tags = {
    Name = "alb"
    # Environment = var.env
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "alb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path    = "/"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 30
    matcher             = "200"
  }
}


resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  tags = {
    Name = "alb-listenter"
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  count            = length(var.public_subnets)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = "${element(var.instance_ids, count.index)}"
  port             = 80
}