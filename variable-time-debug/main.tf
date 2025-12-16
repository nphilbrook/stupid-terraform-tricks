# Will wait during plan
data "external" "wait" {
  program = ["bash", "-c", "while [ ! -f /home/ubuntu/agent/finish_plan ]; do sleep 1; done; echo '{}'"]
}

# Will wait during apply
resource "terraform_data" "wait" {
  triggers_replace = timestamp()
  provisioner "local-exec" {
    command = "while [ ! -f /home/ubuntu/agent/finish_apply ]; do sleep 1; done"
    when    = create
  }
}

resource "random_pet" "name" {
  prefix = timestamp()
}

output "name" {
  value = random_pet.name.id
}
