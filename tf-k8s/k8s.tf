resource "digitalocean_kubernetes_cluster" "tab" {

  name     = "tabk8s"
  region   = "fra1"
  version = "1.19.3-do.2"
  node_pool {
    name       = "tabpool"
    size       = "s-4vcpu-8gb"
    node_count = 1
  }
  tags    = ["tab"]

  provisioner "local-exec" {
    command = "doctl kubernetes cluster kubeconfig save tabk8s"
  }
}
