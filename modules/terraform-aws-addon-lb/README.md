# terraform-aws-addon-lb

표준 3-tier 환경에 Application Load Balancer (ALB)를 추가하는 add-on 모듈입니다. base-3tier workspace의 remote state를 참조하여 통합됩니다.

## 기능

- Application Load Balancer (ALB) 생성
- Target Group 생성 및 Web 인스턴스 연결
- ALB Security Group 생성
- HTTP/HTTPS 리스너 설정
- 헬스 체크 설정

## 사용 예제

```hcl
module "addon_lb" {
  source = "Great-Stone/terraform-platform-engineering-demo/terraform-aws-addon-lb"

  project_name              = "my-project"
  environment               = "dev"
  base_3tier_workspace_name = "my-project-dev-base-3tier"
  
  alb_name = "my-project-dev-alb"
  
  target_port = 80
  target_protocol = "HTTP"
  
  health_check_path = "/"
  
  tags = {
    Team = "platform"
  }
}
```

HTTPS 리스너를 사용하는 경우:

```hcl
module "addon_lb" {
  source = "Great-Stone/terraform-platform-engineering-demo/terraform-aws-addon-lb"

  project_name              = "my-project"
  environment               = "dev"
  base_3tier_workspace_name = "my-project-dev-base-3tier"
  
  listener_protocol = "HTTPS"
  certificate_arn   = "arn:aws:acm:region:account:certificate/cert-id"
  
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
| alb_name | ALB 이름 | `string` | `""` (자동 생성) | 아니오 |
| internal | 내부 ALB 여부 | `bool` | `false` | 아니오 |
| load_balancer_type | 로드 밸런서 타입 | `string` | `"application"` | 아니오 |
| enable_deletion_protection | 삭제 보호 활성화 | `bool` | `false` | 아니오 |
| enable_http2 | HTTP/2 활성화 | `bool` | `true` | 아니오 |
| idle_timeout | 유휴 타임아웃 (초) | `number` | `60` | 아니오 |
| target_type | 타겟 타입 (instance, ip, lambda) | `string` | `"instance"` | 아니오 |
| target_port | 타겟 포트 | `number` | `80` | 아니오 |
| target_protocol | 타겟 프로토콜 (HTTP, HTTPS) | `string` | `"HTTP"` | 아니오 |
| health_check_path | 헬스 체크 경로 | `string` | `"/"` | 아니오 |
| health_check_interval | 헬스 체크 간격 (초) | `number` | `30` | 아니오 |
| health_check_timeout | 헬스 체크 타임아웃 (초) | `number` | `5` | 아니오 |
| healthy_threshold | 정상 임계값 | `number` | `2` | 아니오 |
| unhealthy_threshold | 비정상 임계값 | `number` | `2` | 아니오 |
| listener_port | 리스너 포트 | `number` | `80` | 아니오 |
| listener_protocol | 리스너 프로토콜 (HTTP, HTTPS) | `string` | `"HTTP"` | 아니오 |
| certificate_arn | SSL 인증서 ARN (HTTPS 리스너인 경우) | `string` | `null` | 아니오 |
| tags | 추가 태그 | `map(string)` | `{}` | 아니오 |

## 출력 값

| 이름 | 설명 |
|------|------|
| alb_id | ALB ID |
| alb_arn | ALB ARN |
| alb_dns_name | ALB DNS 이름 |
| alb_zone_id | ALB Zone ID |
| target_group_id | Target Group ID |
| target_group_arn | Target Group ARN |
| alb_security_group_id | ALB Security Group ID |
| vpc_id | base-3tier에서 참조한 VPC ID |
| project_name | 프로젝트 이름 |
| environment | 환경 |

## Remote State 참조

이 모듈은 `terraform_remote_state` 데이터 소스를 사용하여 base-3tier workspace의 출력값을 참조합니다.

- **조직**: `great-stone-biz`
- **Workspace**: `var.base_3tier_workspace_name`으로 지정

참조하는 출력값:
- `vpc_id`: VPC ID
- `public_subnet_ids`: Public 서브넷 ID 목록
- `web_instance_ids`: Web 인스턴스 ID 목록

## 요구사항

- Terraform >= 1.0
- AWS Provider >= 5.0
- base-3tier workspace가 이미 배포되어 있어야 함

## 라이선스

이 모듈은 MIT 라이선스 하에 제공됩니다.

