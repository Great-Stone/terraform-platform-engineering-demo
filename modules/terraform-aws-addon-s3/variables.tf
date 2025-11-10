variable "project_name" {
  description = "프로젝트 이름"
  type        = string
}

variable "environment" {
  description = "환경 (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "base_3tier_workspace_name" {
  description = "base-3tier workspace 이름 (remote state 참조용)"
  type        = string
}

variable "bucket_name" {
  description = "S3 버킷 이름 (전역적으로 고유해야 함)"
  type        = string
}

variable "enable_versioning" {
  description = "버킷 버전 관리 활성화"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "버킷 암호화 활성화"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "암호화 알고리즘 (AES256 또는 aws:kms)"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "KMS 키 ID (encryption_algorithm이 aws:kms인 경우)"
  type        = string
  default     = null
}

variable "block_public_acls" {
  description = "Public ACL 차단"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Public 정책 차단"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Public ACL 무시"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Public 버킷 제한"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "버킷 생명주기 규칙"
  type = list(object({
    id     = string
    status = string
    expiration = optional(object({
      days = number
    }))
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })))
  }))
  default = []
}

variable "tags" {
  description = "추가 태그"
  type        = map(string)
  default     = {}
}

