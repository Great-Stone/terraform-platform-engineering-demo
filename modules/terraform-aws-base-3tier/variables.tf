variable "project_name" {
  description = "프로젝트 이름"
  type        = string
}

variable "environment" {
  description = "환경 (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR 블록"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "사용할 가용 영역 목록"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "public_subnet_cidrs" {
  description = "Public 서브넷 CIDR 블록 목록"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private 서브넷 CIDR 블록 목록"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "rds_subnet_cidrs" {
  description = "RDS 서브넷 CIDR 블록 목록"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "web_instance_type" {
  description = "Web 서버 인스턴스 타입"
  type        = string
}

variable "was_instance_type" {
  description = "WAS 서버 인스턴스 타입"
  type        = string
}

variable "web_instance_count" {
  description = "Web 서버 인스턴스 개수"
  type        = number
}

variable "was_instance_count" {
  description = "WAS 서버 인스턴스 개수"
  type        = number
}

variable "db_instance_class" {
  description = "RDS 인스턴스 클래스"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "RDS 할당된 스토리지 (GB)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "데이터베이스 이름"
  type        = string
  default     = "mydb"
}

variable "db_username" {
  description = "데이터베이스 마스터 사용자 이름"
  type        = string
  default     = "postgres"
  sensitive   = true
}

variable "db_password" {
  description = "데이터베이스 마스터 비밀번호"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "데이터베이스 포트"
  type        = number
  default     = 5432
}

variable "db_engine_version" {
  description = "PostgreSQL 엔진 버전"
  type        = string
  default     = "15.4"
}

variable "tags" {
  description = "추가 태그"
  type        = map(string)
  default     = {}
}

