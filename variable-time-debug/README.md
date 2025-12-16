# Variable Time Debug Workspace

## Overview

This Terraform workspace is designed to introduce controllable, manual delays during the `plan` and `apply` phases. It allows an operator to pause Terraform operations at specific points and resume them by creating signal files on the filesystem.

## Use Cases

This technique is useful for:

- **Testing state locking behavior** - Hold a plan or apply to verify state lock timeouts and conflict handling
- **Debugging concurrent operations** - Pause one run to test behavior when multiple runs attempt to execute
- **Inspecting intermediate state** - Hold a run to examine workspace state or resource conditions mid-operation
- **Simulating slow operations** - Test application behavior when Terraform runs take extended time
- **Testing run queueing** - Verify how Terraform Cloud/Enterprise handles queued runs when one is in progress

## How It Works

### Plan Phase Wait

```terraform
data "external" "wait" {
  program = ["bash", "-c", "while [ ! -f /home/ubuntu/agent/finish_plan ]; do sleep 1; done; echo '{}'"]
}
```

The `external` data source executes during the plan phase. It polls every second for the existence of `/home/ubuntu/agent/finish_plan`. The plan will be held until this file is created.

**To release the plan:**
```bash
touch /home/ubuntu/agent/finish_plan
```

### Apply Phase Wait

```terraform
resource "terraform_data" "wait" {
  triggers_replace = timestamp()
  provisioner "local-exec" {
    command = "while [ ! -f /home/ubuntu/agent/finish_apply ]; do sleep 1; done"
    when    = create
  }
}
```

The `terraform_data` resource with a `local-exec` provisioner executes during apply. The `triggers_replace` uses `timestamp()` to force replacement on every run, ensuring the provisioner executes. It polls for `/home/ubuntu/agent/finish_apply`.

**To release the apply:**
```bash
touch /home/ubuntu/agent/finish_apply
```

### Sample Resource

A `random_pet` resource is included to demonstrate actual infrastructure changes alongside the wait mechanisms.

## Notes / Warnings

- To use this approach, you must self-host an agent somewhere where you can access the filesystem to create the files.
- To repeat, *if you try to run this code using the default global agent pool on HCP Terraform, it will never complete*
- The paths `/home/ubuntu/agent/finish_plan` and `/home/ubuntu/agent/finish_apply` are specific to the environment where this is intended to run (likely a Terraform Cloud/Enterprise agent running on Ubuntu)
- You may need to adjust these paths based on your execution environment
- Remember to clean up the signal files between runs if you want to test the wait behavior multiple times
- The `timestamp()` function ensures the `terraform_data` resource is replaced on every apply
