resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.networking_layer.outputs.alb_sg_id]
  subnets            = [data.terraform_remote_state.networking_layer.outputs.public_subnet_id, data.terraform_remote_state.networking_layer.outputs.private_subnet_id]

  enable_deletion_protection = false

  tags = {
    Name = "main-alb"
  }
}

resource "aws_lb_target_group" "blue" {
  name     = var.blue_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.networking_layer.outputs.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name = "blue-target-group"
  }
}

resource "aws_lb_target_group" "green" {
  name     = var.green_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.networking_layer.outputs.vpc_id

  health_check {
    enabled             = true
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = "traffic-port"
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
    matcher             = "200"
  }

  tags = {
    Name = "green-target-group"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn // Default traffic goes to green target group
  }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}