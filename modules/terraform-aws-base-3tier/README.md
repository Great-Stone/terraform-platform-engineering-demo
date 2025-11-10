# terraform-aws-base-3tier

표준 3-tier 아키텍처를 제공하는 Terraform 모듈입니다. VPC, Public/Private 서브넷, Web/WAS EC2 인스턴스, RDS PostgreSQL을 포함합니다.

## 기능

- VPC 및 네트워크 구성
  - Public 서브넷 (Web 서버용)
  - Private 서브넷 (WAS 서버용)
  - RDS 서브넷 (데이터베이스용)
  - Internet Gateway
  - NAT Gateway
  - Route Tables

- 보안 그룹
  - Web 서버용 보안 그룹
  - WAS 서버용 보안 그룹
  - RDS용 보안 그룹

- 컴퓨팅 리소스
  - Web 서버 EC2 인스턴스
  - WAS 서버 EC2 인스턴스

- 데이터베이스
  - RDS PostgreSQL 인스턴스

## 사용 예제

```hcl
module "base_3tier" {
  source = "Great-Stone/terraform-platform-engineering-demo/terraform-aws-base-3tier"

  project_name = "my-project"
  environment  = "dev"
  
  vpc_cidr = "10.0.0.0/16"
  
  web_instance_type = "t3.micro"
  was_instance_type = "t3.micro"
  
  db_instance_class = "db.t3.micro"
  db_password       = "your-secure-password"
  
  tags = {
    Team = "platform"
  }
}
```

## 입력 변수

| 이름 | 설명 | 타입 | 기본값 | 필수 |
|------|------|------|--------|------|
| project_name | 프로젝트 이름 | `string` | - | 예 |
| environment | 환경 (dev, staging, prod) | `string` | `"dev"` | 아니오 |
| vpc_cidr | VPC CIDR 블록 | `string` | `"10.0.0.0/16"` | 아니오 |
| availability_zones | 사용할 가용 영역 목록 | `list(string)` | `["ap-northeast-2a", "ap-northeast-2c"]` | 아니오 |
| public_subnet_cidrs | Public 서브넷 CIDR 블록 목록 | `list(string)` | `["10.0.1.0/24", "10.0.2.0/24"]` | 아니오 |
| private_subnet_cidrs | Private 서브넷 CIDR 블록 목록 | `list(string)` | `["10.0.11.0/24", "10.0.12.0/24"]` | 아니오 |
| rds_subnet_cidrs | RDS 서브넷 CIDR 블록 목록 | `list(string)` | `["10.0.21.0/24", "10.0.22.0/24"]` | 아니오 |
| web_instance_type | Web 서버 인스턴스 타입 | `string` | `"t3.micro"` | 아니오 |
| was_instance_type | WAS 서버 인스턴스 타입 | `string` | `"t3.micro"` | 아니오 |
| web_instance_count | Web 서버 인스턴스 개수 | `number` | `1` | 아니오 |
| was_instance_count | WAS 서버 인스턴스 개수 | `number` | `1` | 아니오 |
| db_instance_class | RDS 인스턴스 클래스 | `string` | `"db.t3.micro"` | 아니오 |
| db_allocated_storage | RDS 할당된 스토리지 (GB) | `number` | `20` | 아니오 |
| db_name | 데이터베이스 이름 | `string` | `"mydb"` | 아니오 |
| db_username | 데이터베이스 마스터 사용자 이름 | `string` | `"postgres"` | 아니오 |
| db_password | 데이터베이스 마스터 비밀번호 | `string` | - | 예 |
| db_port | 데이터베이스 포트 | `number` | `5432` | 아니오 |
| db_engine_version | PostgreSQL 엔진 버전 | `string` | `"15.13"` | 아니오 |
| tags | 추가 태그 | `map(string)` | `{}` | 아니오 |

[PostgreSQL 엔진 버전 목록](https://docs.aws.amazon.com/ko_kr/AmazonRDS/latest/PostgreSQLReleaseNotes/doc-history.html)

## 출력 값

| 이름 | 설명 |
|------|------|
| vpc_id | VPC ID |
| vpc_cidr_block | VPC CIDR 블록 |
| public_subnet_ids | Public 서브넷 ID 목록 |
| private_subnet_ids | Private 서브넷 ID 목록 |
| rds_subnet_ids | RDS 서브넷 ID 목록 |
| internet_gateway_id | Internet Gateway ID |
| nat_gateway_ids | NAT Gateway ID 목록 |
| web_security_group_id | Web Security Group ID |
| was_security_group_id | WAS Security Group ID |
| rds_security_group_id | RDS Security Group ID |
| web_instance_ids | Web 인스턴스 ID 목록 |
| web_instance_private_ips | Web 인스턴스 Private IP 목록 |
| web_instance_public_ips | Web 인스턴스 Public IP 목록 |
| was_instance_ids | WAS 인스턴스 ID 목록 |
| was_instance_private_ips | WAS 인스턴스 Private IP 목록 |
| rds_endpoint | RDS 엔드포인트 |
| rds_address | RDS 주소 |
| rds_port | RDS 포트 |
| rds_db_name | RDS 데이터베이스 이름 |
| project_name | 프로젝트 이름 |
| environment | 환경 |

## 요구사항

- Terraform >= 1.0
- AWS Provider >= 5.0

## 라이선스

이 모듈은 MIT 라이선스 하에 제공됩니다.

