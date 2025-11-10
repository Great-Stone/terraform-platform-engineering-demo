variable "tfe_hostname" {
  description = "TFE/HCP Terraform 호스트명"
  type        = string
  default     = "app.terraform.io"
}

variable "tfe_token" {
  description = "TFE/HCP Terraform API 토큰"
  type        = string
  sensitive   = true
}

variable "tfe_organization" {
  description = "TFE/HCP Terraform 조직 이름"
  type        = string
  default     = "great-stone-biz"
}

variable "github_repo_identifier" {
  description = "GitHub 저장소 식별자 (organization/repository 형식)"
  type        = string
  default     = "Great-Stone/terraform-platform-engineering-demo"
}

variable "github_branch" {
  description = "GitHub 브랜치 이름"
  type        = string
  default     = "main"
}

variable "github_oauth_token_id" {
  description = "GitHub OAuth 토큰 ID (VCS 연결용)"
  type        = string
}

