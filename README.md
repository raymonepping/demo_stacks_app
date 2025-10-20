# demo_stacks_app

This repository contains the **application sidecar Stack** for the HUG workshop.
It demonstrates how an application Stack can **consume outputs from an upstream infrastructure Stack** (networks and volumes) using Terraform Stacks in HCP Terraform.

## Overview

* **Upstream Stack**: [`demo_stacks_infra`](https://github.com/raymonepping/demo_stacks_infra)
  Provides Docker networks and volumes, and publishes them as outputs.
* **This Stack**: `demo_stacks_app`
  Deploys a simple sidecar container (e.g. NGINX or echo service) and consumes the published outputs from the infra Stack.
* **Deployments**:

  * `development` → sidecar running on dev network/volumes
  * `production` → sidecar running on prod network/volumes

## Prerequisites

* Terraform **v1.13.x** or newer (Stacks GA requires 1.13+)
* Access to HCP Terraform with an Agent Pool that has Docker access
* Cloned upstream repo: [`demo_stacks_infra`](https://github.com/raymonepping/demo_stacks_infra)

## Quickstart

1. Run the bootstrap script (clones both repos, validates, inits):

   ```bash
   bash setup_stacks.sh ~/work/hug-stacks
   ```
2. In HCP Terraform:

   * Create a new Stack and connect it to this repo.
   * Link it to the upstream `demo_stacks_infra` Stack (via **Settings → Linked Stacks**).
   * Set execution mode to **Agent** and select your Agent Pool.
   * Deploy `development` and `production`.

## Local Verification

On the Agent host, after deploy:

```bash
docker ps --format 'table {{.Names}}\t{{.Ports}}' | grep sidecar
curl -I http://localhost:9000  # dev
curl -I http://localhost:9001  # prod
```

## Notes

* Outputs from the infra Stack (`network_name`, `volume_name`, etc.) are published and consumed here via `upstream_input`.
* This repo is designed for workshop/demo use, not production.
