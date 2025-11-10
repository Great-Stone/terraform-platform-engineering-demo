# 모듈 등록 자동화

이 디렉토리는 TFE 프로바이더를 사용하여 no-code 모듈을 HCP Terraform Private Module Registry에 자동으로 등록하는 코드를 포함합니다.

## 개요

[TFE 프로바이더](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs)를 사용하여 다음 모듈들을 자동으로 등록합니다:

- `terraform-aws-base-3tier`
- `terraform-aws-addon-s3`
- `terraform-aws-addon-lb`

## 사전 요구사항

1. **HCP Terraform 계정 및 조직**
   - 조직 이름: `great-stone-biz` (기본값)
   - API 토큰 생성 필요

2. **GitHub OAuth 토큰**
   - HCP Terraform에서 GitHub VCS 연결 설정
   - OAuth 토큰 ID 필요

3. **TFE 프로바이더**
   - Terraform >= 1.0
   - TFE Provider >= 0.0

## 사용 방법

### 1. API 토큰 생성

HCP Terraform에서 User Settings > Tokens로 이동하여 API 토큰을 생성합니다.

### 2. GitHub OAuth 토큰 ID 확인

HCP Terraform에서 Settings > VCS Providers로 이동하여 GitHub 연결을 확인하고 OAuth 토큰 ID를 확인합니다.

### 3. 변수 설정

`terraform.tfvars` 파일을 생성하거나 환경 변수로 설정합니다:

```hcl
tfe_hostname         = "app.terraform.io"
tfe_token            = "your-api-token"
tfe_organization     = "great-stone-biz"
github_repo_identifier = "Great-Stone/terraform-platform-engineering-demo"
github_branch        = "main"
github_oauth_token_id = "ot-xxxxxxxxxxxxx"
```

또는 환경 변수로 설정:

```bash
export TF_VAR_tfe_token="your-api-token"
export TF_VAR_github_oauth_token_id="ot-xxxxxxxxxxxxx"
```

### 4. 모듈 등록

```bash
cd registry
terraform init
terraform plan
terraform apply
```

## 모듈 구조

각 모듈은 GitHub 저장소의 다음 경로에 있어야 합니다:

- `terraform-aws-base-3tier`: `modules/terraform-aws-base-3tier/`
- `terraform-aws-addon-s3`: `modules/terraform-aws-addon-s3/`
- `terraform-aws-addon-lb`: `modules/terraform-aws-addon-lb/`

## 모듈 버전 관리

모듈 버전은 GitHub 태그를 통해 관리됩니다. 새 버전을 릴리스하려면:

1. GitHub에서 태그 생성:
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. HCP Terraform에서 자동으로 새 버전이 감지되고 등록됩니다.

## 입력 변수

| 이름 | 설명 | 타입 | 기본값 | 필수 |
|------|------|------|--------|------|
| tfe_hostname | TFE/HCP Terraform 호스트명 | `string` | `"app.terraform.io"` | 아니오 |
| tfe_token | TFE/HCP Terraform API 토큰 | `string` | - | 예 |
| tfe_organization | TFE/HCP Terraform 조직 이름 | `string` | `"great-stone-biz"` | 아니오 |
| github_repo_identifier | GitHub 저장소 식별자 | `string` | `"Great-Stone/terraform-platform-engineering-demo"` | 아니오 |
| github_branch | GitHub 브랜치 이름 | `string` | `"main"` | 아니오 |
| github_oauth_token_id | GitHub OAuth 토큰 ID | `string` | - | 예 |

## 출력 값

| 이름 | 설명 |
|------|------|
| base_3tier_module_id | Base 3-tier 모듈 ID |
| base_3tier_module_name | Base 3-tier 모듈 이름 |
| addon_s3_module_id | S3 Add-on 모듈 ID |
| addon_s3_module_name | S3 Add-on 모듈 이름 |
| addon_lb_module_id | LB Add-on 모듈 ID |
| addon_lb_module_name | LB Add-on 모듈 이름 |

## 참고 자료

- [TFE Provider 문서](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs)
- [TFE Registry Module 리소스](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/registry_module)
- [HCP Terraform Private Module Registry](https://developer.hashicorp.com/terraform/cloud-docs/registry/publish-modules)

