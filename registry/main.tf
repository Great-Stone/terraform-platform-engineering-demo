# Base 3-tier 모듈 등록
resource "tfe_registry_module" "base_3tier" {
  organization = var.tfe_organization

  vcs_repo {
    display_identifier = "terraform-aws-platform-demo-base-3tier"
    identifier         = var.github_repo_identifier
    branch             = var.github_branch
    oauth_token_id     = var.github_oauth_token_id
    source_directory   = "modules/terraform-aws-base-3tier"
  }

  initial_version = "0.0.0"
}

# S3 Add-on 모듈 등록
resource "tfe_registry_module" "addon_s3" {
  organization = var.tfe_organization

  vcs_repo {
    display_identifier = "terraform-aws-platform-demo-addon-s3"
    identifier         = var.github_repo_identifier
    branch             = var.github_branch
    oauth_token_id     = var.github_oauth_token_id
    source_directory   = "modules/terraform-aws-addon-s3"
  }

  initial_version = "0.0.0"
}

# LB Add-on 모듈 등록
resource "tfe_registry_module" "addon_lb" {
  organization = var.tfe_organization

  vcs_repo {
    display_identifier = "terraform-aws-platform-demo-addon-lb"
    identifier         = var.github_repo_identifier
    branch             = var.github_branch
    oauth_token_id     = var.github_oauth_token_id
    source_directory   = "modules/terraform-aws-addon-lb"
  }

  initial_version = "0.0.0"
}

# Base 3-tier No-Code 모듈
# default가 없는 변수들: project_name, web_instance_type, was_instance_type, web_instance_count, was_instance_count, db_engine_version, db_password
resource "tfe_no_code_module" "base_3tier" {
  organization    = var.tfe_organization
  registry_module = tfe_registry_module.base_3tier.id
  enabled         = true
  version_pin     = "0.0.0"

  variable_options {
    name    = "web_instance_type"
    type    = "string"
    options = ["t3.micro", "t3.small", "t3.medium"]
  }

  variable_options {
    name    = "was_instance_type"
    type    = "string"
    options = ["t3.micro", "t3.small", "t3.medium"]
  }

  variable_options {
    name    = "db_engine_version"
    type    = "string"
    options = ["17.5", "16.9", "15.13"]
  }
}

# S3 Add-on No-Code 모듈
# default가 없는 변수들: project_name, base_3tier_workspace_name, bucket_name
resource "tfe_no_code_module" "addon_s3" {
  organization    = var.tfe_organization
  registry_module = tfe_registry_module.addon_s3.id
  enabled         = true
  version_pin     = "0.0.0"
}

# LB Add-on No-Code 모듈
# default가 없는 변수들: project_name, base_3tier_workspace_name, listener_ports, listeners, target_port
resource "tfe_no_code_module" "addon_lb" {
  organization    = var.tfe_organization
  registry_module = tfe_registry_module.addon_lb.id
  enabled         = true
  version_pin     = "0.0.0"

  variable_options {
    name    = "target_port"
    type    = "string"
    options = ["80", "443", "3000", "8080", "8443", "9000", "9090"]
  }
}

