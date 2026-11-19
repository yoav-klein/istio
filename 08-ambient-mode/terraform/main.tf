terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }

    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "~> 3.5"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
    config_path = "~/.kube/config"
}

resource "helm_release" "base" {
  name             = "istio-base"
  repository       = "https://blob.istio.io/istio-release/charts"
  chart            = "base"
  namespace        = "istio-system"
  create_namespace = true

  version = "1.32.0"

  wait    = true
  timeout = 300
}

resource "helm_release" "istiod" {
  name             = "istiod"
  repository       = "https://blob.istio.io/istio-release/charts"
  chart            = "istiod"
  namespace        = "istio-system"
  create_namespace = true

  set = [
  {
      name = "profile"
      value = "ambient"
  }
  ]


  version = "1.32.0"

  wait    = true
  timeout = 300
}

resource "helm_release" "cni" {
  name             = "cni"
  repository       = "https://blob.istio.io/istio-release/charts"
  chart            = "cni"
  namespace        = "istio-system"
  create_namespace = true

  set = [
  {
      name = "profile"
      value = "ambient"
  }
  ]


  version = "1.32.0"

  wait    = true
  timeout = 300
}

resource "helm_release" "ztunnel" {
  name             = "ztunnel"
  repository       = "https://blob.istio.io/istio-release/charts"
  chart            = "ztunnel"
  namespace        = "istio-system"
  create_namespace = true

  version = "1.32.0"

  wait    = true
  timeout = 300
}

data "http" "gateway_crds" {
    url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.6.0/standard-install.yaml"
}

resource "kubernetes_manifest" "gateway_crds" {
    count = length(provider::kubernetes::manifest_decode_multi(data.http.gateway_crds.response_body))

    manifest = provider::kubernetes::manifest_decode_multi(data.http.gateway_crds.response_body)[count.index]
}

resource "kubernetes_manifest" "waypoint" {
    depends_on = [ kubernetes_manifest.gateway_crds ]

    manifest = yamldecode(file("${path.root}/files/waypoint.yaml"))
}
