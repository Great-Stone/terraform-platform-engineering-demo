output "alb_id" {
  description = "ALB ID"
  value       = aws_lb.main.id
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "ALB DNS 이름"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "ALB Zone ID"
  value       = aws_lb.main.zone_id
}

output "target_group_id" {
  description = "Target Group ID"
  value       = aws_lb_target_group.main.id
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.main.arn
}

output "alb_security_group_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.alb.id
}

output "vpc_id" {
  description = "base-3tier에서 참조한 VPC ID"
  value       = data.terraform_remote_state.base_3tier.outputs.vpc_id
}

output "project_name" {
  description = "프로젝트 이름"
  value       = var.project_name
}

output "environment" {
  description = "환경"
  value       = var.environment
}

