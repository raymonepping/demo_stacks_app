# deployments.tfdeploy.hcl (consumer) — linked via UI
upstream_input "platform" {
  type = "stack"
  source = "app.terraform.io/hashicorp/Default Project/demo_stacks_infra"
}

deployment "development" {
  inputs = {
    name         = "sidecar-dev"
    host_port    = 9010
    message      = "hello from dev"
    network_name = upstream_input.platform.dev_network_name
  }
}

deployment "production" {
  inputs = {
    name         = "sidecar-prod"
    host_port    = 9011
    message      = "hello from prod"
    network_name = upstream_input.platform.prod_network_name
  }
}
