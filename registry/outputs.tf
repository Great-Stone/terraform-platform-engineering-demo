output "base_3tier_module_id" {
  description = "Base 3-tier 모듈 ID"
  value       = tfe_registry_module.base_3tier.id
}

output "base_3tier_module_name" {
  description = "Base 3-tier 모듈 이름"
  value       = tfe_registry_module.base_3tier.name
}

output "addon_s3_module_id" {
  description = "S3 Add-on 모듈 ID"
  value       = tfe_registry_module.addon_s3.id
}

output "addon_s3_module_name" {
  description = "S3 Add-on 모듈 이름"
  value       = tfe_registry_module.addon_s3.name
}

output "addon_lb_module_id" {
  description = "LB Add-on 모듈 ID"
  value       = tfe_registry_module.addon_lb.id
}

output "addon_lb_module_name" {
  description = "LB Add-on 모듈 이름"
  value       = tfe_registry_module.addon_lb.name
}

