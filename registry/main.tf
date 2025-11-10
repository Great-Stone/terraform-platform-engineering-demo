terraform {
  required_version = ">= 1.0"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.0"
    }
  }
}

provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}

# Base 3-tier 모듈 등록
resource "tfe_registry_module" "base_3tier" {
  organization = var.tfe_organization
  name         = "terraform-aws-base-3tier"
  provider     = "aws"
  namespace    = var.tfe_organization

  vcs_repo {
    identifier         = var.github_repo_identifier
    branch             = var.github_branch
    ingress_submodules = false
    oauth_token_id     = var.github_oauth_token_id
  }
}

# S3 Add-on 모듈 등록
resource "tfe_registry_module" "addon_s3" {
  organization = var.tfe_organization
  name         = "terraform-aws-addon-s3"
  provider     = "aws"
  namespace    = var.tfe_organization

  vcs_repo {
    identifier         = var.github_repo_identifier
    branch             = var.github_branch
    ingress_submodules = false
    oauth_token_id     = var.github_oauth_token_id
  }
}

# LB Add-on 모듈 등록
resource "tfe_registry_module" "addon_lb" {
  organization = var.tfe_organization
  name         = "terraform-aws-addon-lb"
  provider     = "aws"
  namespace    = var.tfe_organization

  vcs_repo {
    identifier         = var.github_repo_identifier
    branch             = var.github_branch
    ingress_submodules = false
    oauth_token_id     = var.github_oauth_token_id
  }
}

