terraform {
  required_version = ">= 1.0"

  backend "remote" {
    organization = "great-stone-biz"

    workspaces {
      name = "example-base-3tier-with-lb"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

# Base 3-tier 모듈
module "base_3tier" {
  source = "../../modules/terraform-aws-base-3tier"

  project_name = "example"
  environment  = "dev"

  vpc_cidr = "10.0.0.0/16"

  availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  rds_subnet_cidrs     = ["10.0.21.0/24", "10.0.22.0/24"]

  web_instance_type = "t3.micro"
  was_instance_type = "t3.micro"

  web_instance_count = 2
  was_instance_count = 1

  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 20
  db_name              = "exampledb"
  db_username          = "postgres"
  db_password          = "ChangeMe123!" # 실제 환경에서는 변수나 Secrets Manager 사용
  db_port              = 5432
  db_engine_version    = "15.4"

  tags = {
    Example = "true"
    Team    = "platform"
  }
}

# ALB Add-on 모듈 (base-3tier workspace의 remote state 참조)
module "addon_lb" {
  source = "../../modules/terraform-aws-addon-lb"

  project_name              = "example"
  environment               = "dev"
  base_3tier_workspace_name = "example-base-3tier" # base-3tier workspace 이름

  alb_name = "example-dev-alb"

  internal = false
  enable_deletion_protection = false
  enable_http2 = true
  idle_timeout = 60

  target_type     = "instance"
  target_port     = 80
  target_protocol = "HTTP"

  health_check_path     = "/"
  health_check_interval = 30
  health_check_timeout  = 5
  healthy_threshold     = 2
  unhealthy_threshold   = 2

  listener_port     = 80
  listener_protocol = "HTTP"

  tags = {
    Example = "true"
    Team    = "platform"
  }
}

