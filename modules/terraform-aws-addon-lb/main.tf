locals {
  name_prefix = "${var.project_name}-${var.environment}"
  alb_name    = var.alb_name != "" ? var.alb_name : "${local.name_prefix}-alb"
  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      Module      = "addon-lb"
      ManagedBy   = "terraform"
    },
    var.tags
  )

  vpc_id             = data.terraform_remote_state.base_3tier.outputs.vpc_id
  public_subnet_ids = data.terraform_remote_state.base_3tier.outputs.public_subnet_ids
  web_instance_ids  = data.terraform_remote_state.base_3tier.outputs.web_instance_ids
}

# Security Group for ALB
resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = local.vpc_id

  dynamic "ingress" {
    for_each = var.listener_ports
    content {
      description = "Allow inbound traffic on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${local.name_prefix}-alb-sg"
    },
    local.common_tags
  )
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = local.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.alb.id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = var.enable_deletion_protection
  enable_http2               = var.enable_http2
  idle_timeout               = var.idle_timeout

  tags = merge(
    {
      Name = local.alb_name
    },
    local.common_tags
  )
}

# Target Group
resource "aws_lb_target_group" "main" {
  name     = "${local.name_prefix}-tg"
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = local.vpc_id

  target_type = var.target_type

  health_check {
    enabled             = true
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    path                = var.health_check_path
    protocol            = var.target_protocol
    matcher             = "200"
  }

  tags = merge(
    {
      Name = "${local.name_prefix}-tg"
    },
    local.common_tags
  )
}

# Target Group Attachment - Web Instances
resource "aws_lb_target_group_attachment" "web" {
  count            = length(local.web_instance_ids)
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = local.web_instance_ids[count.index]
  port             = var.target_port
}

# ALB Listeners
resource "aws_lb_listener" "main" {
  for_each = var.listeners

  load_balancer_arn = aws_lb.main.arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  # SSL 설정 (HTTPS인 경우)
  ssl_policy      = each.value.protocol == "HTTPS" ? (each.value.ssl_policy != null ? each.value.ssl_policy : "ELBSecurityPolicy-TLS-1-2-2017-01") : null
  certificate_arn = each.value.certificate_arn
}

