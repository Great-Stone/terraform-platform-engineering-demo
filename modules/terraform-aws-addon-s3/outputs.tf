output "bucket_id" {
  description = "S3 버킷 ID"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "S3 버킷 ARN"
  value       = aws_s3_bucket.main.arn
}

output "bucket_domain_name" {
  description = "S3 버킷 도메인 이름"
  value       = aws_s3_bucket.main.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "S3 버킷 지역 도메인 이름"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}

output "bucket_name" {
  description = "S3 버킷 이름"
  value       = aws_s3_bucket.main.id
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

