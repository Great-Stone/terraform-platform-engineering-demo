data "terraform_remote_state" "base_3tier" {
  backend = "remote"

  config = {
    organization = "great-stone-biz"
    workspaces = {
      name = var.base_3tier_workspace_name
    }
  }
}

