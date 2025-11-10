# Terraform Platform Engineering Demo

HCP Terraform을 활용한 플랫폼 엔지니어링 데모 프로젝트입니다. No-code 모듈을 통해 사용자에게 표준 3-tier 환경과 add-on 리소스를 제공합니다.

## 개요

이 프로젝트는 HCP Terraform의 Private Module Registry를 활용하여 플랫폼 엔지니어링 데모를 제공합니다. 사용자는 코드 없이 표준 3-tier 아키텍처를 배포하고, 필요에 따라 S3나 Load Balancer 같은 add-on 리소스를 추가할 수 있습니다.

## 모듈 구조

### Base 모듈

#### terraform-aws-base-3tier

표준 3-tier 아키텍처를 제공하는 기본 모듈입니다.

**구성 요소:**
- VPC 및 네트워크 구성 (Public/Private/RDS 서브넷)
- Internet Gateway 및 NAT Gateway
- Security Groups (Web, WAS, RDS)
- EC2 인스턴스 (Web 서버, WAS 서버)
- RDS PostgreSQL 인스턴스

**사용 예제:**
```hcl
module "base_3tier" {
  source = "Great-Stone/terraform-platform-engineering-demo/terraform-aws-base-3tier"

  project_name = "my-project"
  environment  = "dev"
  
  db_password = "your-secure-password"
}
```

### Add-on 모듈

#### terraform-aws-addon-s3

표준 3-tier 환경에 S3 버킷을 추가하는 add-on 모듈입니다.

**특징:**
- base-3tier workspace의 remote state를 참조
- 버킷 버전 관리 및 암호화 설정
- Public Access 차단

**사용 예제:**
```hcl
module "addon_s3" {
  source = "Great-Stone/terraform-platform-engineering-demo/terraform-aws-addon-s3"

  project_name              = "my-project"
  environment               = "dev"
  base_3tier_workspace_name = "my-project-dev-base-3tier"
  
  bucket_name = "my-project-dev-bucket"
}
```

#### terraform-aws-addon-lb

표준 3-tier 환경에 Application Load Balancer를 추가하는 add-on 모듈입니다.

**특징:**
- base-3tier workspace의 remote state를 참조
- Web 인스턴스를 자동으로 타겟 그룹에 연결
- HTTP/HTTPS 리스너 지원

**사용 예제:**
```hcl
module "addon_lb" {
  source = "Great-Stone/terraform-platform-engineering-demo/terraform-aws-addon-lb"

  project_name              = "my-project"
  environment               = "dev"
  base_3tier_workspace_name = "my-project-dev-base-3tier"
  
  alb_name = "my-project-dev-alb"
}
```

## 모듈 네이밍 규칙

모듈 이름을 통해 base 아키텍처와 add-on을 구분할 수 있습니다:

- **Base 모듈**: `terraform-aws-base-3tier`
- **Add-on 모듈**: `terraform-aws-addon-s3`, `terraform-aws-addon-lb`

## Remote State 통합

Add-on 모듈들은 `terraform_remote_state` 데이터 소스를 사용하여 base-3tier workspace의 출력값을 참조합니다.

**조직**: `great-stone-biz`

**참조 방식:**
```hcl
data "terraform_remote_state" "base_3tier" {
  backend = "remote"
  config = {
    organization = "great-stone-biz"
    workspaces {
      name = var.base_3tier_workspace_name
    }
  }
}
```

이를 통해 add-on 모듈은 base-3tier workspace 이름만 알면 필요한 모든 정보를 자동으로 가져올 수 있습니다.

## 프로젝트 구조

```
terraform-platform-engineering-demo/
├── modules/
│   ├── terraform-aws-base-3tier/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── versions.tf
│   │   └── README.md
│   ├── terraform-aws-addon-s3/
│   │   ├── main.tf
│   │   ├── data.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── versions.tf
│   │   └── README.md
│   └── terraform-aws-addon-lb/
│       ├── main.tf
│       ├── data.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── versions.tf
│       └── README.md
├── examples/
│   ├── base-3tier/
│   │   └── main.tf
│   ├── base-3tier-with-s3/
│   │   ├── main.tf
│   │   └── versions.tf
│   └── base-3tier-with-lb/
│       ├── main.tf
│       └── versions.tf
├── registry/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── versions.tf
│   ├── README.md
│   └── .gitignore
└── README.md
```

## 사용 방법

### 1. Base 3-tier 환경 배포

먼저 base-3tier 모듈을 사용하여 기본 인프라를 배포합니다.

```bash
cd examples/base-3tier
terraform init
terraform plan
terraform apply
```

### 2. Add-on 리소스 추가

Base 3-tier 환경이 배포된 후, add-on 모듈을 사용하여 추가 리소스를 배포할 수 있습니다.

**S3 추가:**
```bash
cd examples/base-3tier-with-s3
terraform init
terraform plan
terraform apply
```

**Load Balancer 추가:**
```bash
cd examples/base-3tier-with-lb
terraform init
terraform plan
terraform apply
```

## HCP Terraform 등록

각 모듈은 HCP Terraform Private Module Registry에 등록할 수 있습니다.

### 자동 등록 (권장)

TFE 프로바이더를 사용하여 모듈을 자동으로 등록할 수 있습니다:

```bash
cd registry
terraform init
terraform plan
terraform apply
```

자세한 내용은 [registry/README.md](registry/README.md)를 참고하세요.

### 수동 등록

1. GitHub 저장소에 모듈 코드 푸시
2. HCP Terraform에서 Private Module Registry로 이동
3. 모듈 등록 및 버전 태그 생성

## 요구사항

- Terraform >= 1.0
- AWS Provider >= 5.0
- HCP Terraform 계정 및 조직 (`great-stone-biz`)

## 라이선스

이 프로젝트는 MIT 라이선스 하에 제공됩니다.

## 기여

기여를 환영합니다! 이슈를 생성하거나 Pull Request를 제출해주세요.

