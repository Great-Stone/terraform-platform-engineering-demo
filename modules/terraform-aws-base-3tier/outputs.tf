output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "VPC CIDR 블록"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "Public 서브넷 ID 목록"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private 서브넷 ID 목록"
  value       = aws_subnet.private[*].id
}

output "rds_subnet_ids" {
  description = "RDS 서브넷 ID 목록"
  value       = aws_subnet.rds[*].id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
  description = "NAT Gateway ID 목록"
  value       = aws_nat_gateway.main[*].id
}

output "web_security_group_id" {
  description = "Web Security Group ID"
  value       = aws_security_group.web.id
}

output "was_security_group_id" {
  description = "WAS Security Group ID"
  value       = aws_security_group.was.id
}

output "rds_security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds.id
}

output "web_instance_ids" {
  description = "Web 인스턴스 ID 목록"
  value       = aws_instance.web[*].id
}

output "web_instance_private_ips" {
  description = "Web 인스턴스 Private IP 목록"
  value       = aws_instance.web[*].private_ip
}

output "web_instance_public_ips" {
  description = "Web 인스턴스 Public IP 목록"
  value       = aws_instance.web[*].public_ip
}

output "was_instance_ids" {
  description = "WAS 인스턴스 ID 목록"
  value       = aws_instance.was[*].id
}

output "was_instance_private_ips" {
  description = "WAS 인스턴스 Private IP 목록"
  value       = aws_instance.was[*].private_ip
}

output "project_name" {
  description = "프로젝트 이름"
  value       = var.project_name
}

output "environment" {
  description = "환경"
  value       = var.environment
}

