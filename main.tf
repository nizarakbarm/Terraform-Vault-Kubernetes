#Define config path of provider kubernetes and helm
provider "kubernetes" {
    config_path = "~/.kube/config"
}
provider "helm" {
    config_path = "~/.kube/config"
}

#Create namespace for vault
resource "kubernetes_namespace" "createnamespacevault" {
    metadata {
        name = "vault"
    }
}

#install vault using helm
resource "helm_release" "vault" {
    name = "vault"
    namespace = "vault"
    repository = "https://helm.releases.hashicorp"
    chart = "vault"

    values = [
        <<-EOF
        server:
            affinity: ""
            ha:
                enabled: true
                raft:
                    enabled: true
        EOF
    ]
}

