# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "name"        { 
  type = string 
  default = "sidecar" 
}
variable "image"       { 
  type = string 
  default = "hashicorp/http-echo" 
}
variable "host_port"   { 
  type = number 
  default = 9000 
}
variable "message"     { 
  type = string 
  default = "hello from consumer" 
}
variable "network_name"{ 
  type = string 
}

required_providers {
  docker = { source = "kreuzwerker/docker", version = "~> 3.0" }
}

provider "docker" "this" {}

component "sidecar" {
  source = "./sidecar"
  inputs = {
    name         = var.name
    image        = var.image
    host_port    = var.host_port
    message      = var.message
    network_name = var.network_name
  }
  providers = { docker = provider.docker.this }
}