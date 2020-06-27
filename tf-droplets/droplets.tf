provider "digitalocean" {}

variable "vm_count" {
  default = 1
}

data "digitalocean_ssh_key" "default" {
  name = "rdpanek"
}

data "digitalocean_image" "tab" {
  name = "wpt2-demo-docker-vnc-dns-google-chrome-v2"
}

resource "digitalocean_droplet" "tab" {
  count = var.vm_count

  image    = data.digitalocean_image.tab.id
  name     = "tab${count.index}"
  region   = "fra1"
  size     = "s-4vcpu-8gb"
  monitoring = true
  ssh_keys = [
    data.digitalocean_ssh_key.default.fingerprint
  ]

  connection {
    type = "ssh"
    user = "root"
    host = self.ipv4_address
  }
}

output "ip" {
  value = [
    for instance in digitalocean_droplet.tab: instance.ipv4_address
  ]
}