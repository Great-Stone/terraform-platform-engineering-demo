# terraform-aws-addon-s3

표준 3-tier 환경에 S3 버킷을 추가하는 add-on 모듈입니다. base-3tier workspace의 remote state를 참조하여 통합됩니다.

## 기능

- S3 버킷 생성
- 버킷 버전 관리 설정
- 서버 측 암호화 설정
- Public Access 차단 설정
- 생명주기 규칙 설정 (선택적)

## 사용 예제

```hcl
module "addon_s3" {
  source = "Great-Stone/terraform-platform-engineering-demo/terraform-aws-addon-s3"

  project_name              = "my-project"
  environment               = "dev"
  base_3tier_workspace_name = "my-project-dev-base-3tier"
  
  bucket_name = "my-project-dev-bucket"
  
  enable_versioning = true
  enable_encryption = true
  
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
| base_3tier_workspace_name | base-3tier workspace 이름 (remote state 참조용) | `string` | - | 예 |
| bucket_name | S3 버킷 이름 (전역적으로 고유해야 함) | `string` | - | 예 |
| enable_versioning | 버킷 버전 관리 활성화 | `bool` | `true` | 아니오 |
| enable_encryption | 버킷 암호화 활성화 | `bool` | `true` | 아니오 |
| encryption_algorithm | 암호화 알고리즘 (AES256 또는 aws:kms) | `string` | `"AES256"` | 아니오 |
| kms_key_id | KMS 키 ID (encryption_algorithm이 aws:kms인 경우) | `string` | `null` | 아니오 |
| block_public_acls | Public ACL 차단 | `bool` | `true` | 아니오 |
| block_public_policy | Public 정책 차단 | `bool` | `true` | 아니오 |
| ignore_public_acls | Public ACL 무시 | `bool` | `true` | 아니오 |
| restrict_public_buckets | Public 버킷 제한 | `bool` | `true` | 아니오 |
| lifecycle_rules | 버킷 생명주기 규칙 | `list(object)` | `[]` | 아니오 |
| tags | 추가 태그 | `map(string)` | `{}` | 아니오 |

## 출력 값

| 이름 | 설명 |
|------|------|
| bucket_id | S3 버킷 ID |
| bucket_arn | S3 버킷 ARN |
| bucket_domain_name | S3 버킷 도메인 이름 |
| bucket_regional_domain_name | S3 버킷 지역 도메인 이름 |
| bucket_name | S3 버킷 이름 |
| vpc_id | base-3tier에서 참조한 VPC ID |
| project_name | 프로젝트 이름 |
| environment | 환경 |

## Remote State 참조

이 모듈은 `terraform_remote_state` 데이터 소스를 사용하여 base-3tier workspace의 출력값을 참조합니다.

- **조직**: `great-stone-biz`
- **Workspace**: `var.base_3tier_workspace_name`으로 지정

참조하는 출력값:
- `vpc_id`: VPC ID

## 요구사항

- Terraform >= 1.0
- AWS Provider >= 5.0
- base-3tier workspace가 이미 배포되어 있어야 함

## 라이선스

이 모듈은 MIT 라이선스 하에 제공됩니다.

