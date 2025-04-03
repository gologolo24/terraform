resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = var.helm_chart_config["argocd"].namespace
  create_namespace = true
  version          = var.helm_chart_config["argocd"].version
  values           = [file("argocd-values.yaml")]
}

resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = var.helm_chart_config["nginx_ingress"].namespace
  create_namespace = true
  version          = var.helm_chart_config["nginx_ingress"].version
  values           = [file("nginx.yaml")]
}

resource "helm_release" "prometheus" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.helm_chart_config["prometheus"].namespace
  create_namespace = true
  version          = var.helm_chart_config["prometheus"].version
  values           = [file("prometheus-values.yaml")]
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = var.helm_chart_config["cert_manager"].namespace
  create_namespace = true
  version          = var.helm_chart_config["cert_manager"].version
  values           = [file("cert-manager-values.yaml")]
}

resource "helm_release" "rancher" {
  name             = "rancher"
  repository       = "https://releases.rancher.com/server-charts/latest"
  chart            = "rancher"
  namespace        = var.helm_chart_config["rancher"].namespace
  create_namespace = true
  version          = var.helm_chart_config["rancher"].version
  values           = [file("rancher-values.yaml")]

  depends_on = [helm_release.cert_manager]  # Ensures Rancher installs after cert-manager
}