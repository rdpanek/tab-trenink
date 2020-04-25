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

  provisioner "remote-exec" {
    inline = [
        "sudo killall apt apt-get",
        "sudo rm /var/lib/apt/lists/lock",
        "sudo rm /var/cache/apt/archives/lock",
        "sudo rm /var/lib/dpkg/lock*",
        "sudo dpkg --configure -a",
        "sudo apt update",
        "cd /opt && curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && apt install conntrack"
    ]
  }
}

output "ip" {
  value = [
    for instance in digitalocean_droplet.tab: instance.ipv4_address
  ]
}