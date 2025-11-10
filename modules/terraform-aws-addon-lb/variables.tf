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

variable "alb_name" {
  description = "ALB 이름"
  type        = string
  default     = ""
}

variable "internal" {
  description = "내부 ALB 여부"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "로드 밸런서 타입"
  type        = string
  default     = "application"
}

variable "enable_deletion_protection" {
  description = "삭제 보호 활성화"
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "HTTP/2 활성화"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "유휴 타임아웃 (초)"
  type        = number
  default     = 60
}

variable "target_type" {
  description = "타겟 타입 (instance, ip, lambda)"
  type        = string
  default     = "instance"
}

variable "target_port" {
  description = "타겟 포트 (대상 서비스의 포트)"
  type        = number
}

variable "target_protocol" {
  description = "타겟 프로토콜 (HTTP, HTTPS)"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "헬스 체크 경로"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "헬스 체크 간격 (초)"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "헬스 체크 타임아웃 (초)"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "정상 임계값"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "비정상 임계값"
  type        = number
  default     = 2
}

variable "listener_ports" {
  description = "ALB에서 허용할 inbound 포트 목록 (Security Group용)"
  type        = list(number)
}

variable "listeners" {
  description = "ALB 리스너 설정 목록"
  type = map(object({
    port          = number
    protocol      = string
    certificate_arn = optional(string)
    ssl_policy    = optional(string)
  }))
}

variable "tags" {
  description = "추가 태그"
  type        = map(string)
  default     = {}
}

