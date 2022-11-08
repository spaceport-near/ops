locals {
  monitoring = {
    grafana      = "prometheus-grafana"
    prometheus   = "prometheus-kube-prometheus-prometheus"
    alertmanager = "prometheus-kube-prometheus-alertmanager"
  }
  oauth2_proxy = {
    prometheus = {
      client_id     = var.prometheus_github_oauth_client_id
      client_secret = var.prometheus_github_oauth_client_secret
      host_url      = var.prometheus_url
    },
    alertmanager = {
      client_id     = var.alertmanager_github_oauth_client_id
      client_secret = var.alertmanager_github_oauth_client_secret
      host_url      = var.alertmanager_url
    }
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.monitoring_namespace
  }
}

resource "kubernetes_config_map" "grafana_dashboards" {
  metadata {
    name      = "grafana-dashboard-custom"
    namespace = var.monitoring_namespace

    labels = {
      grafana_dashboard = 1
    }

    annotations = {
      k8s-sidecar-target-directory = "/tmp/dashboards/spaceport"
    }
  }
}

data "kubernetes_ingress_v1" "monitoring" {
  for_each = local.monitoring

  metadata {
    name      = each.value
    namespace = var.monitoring_namespace
  }
}

# resource "cloudflare_record" "monitoring" {
#   for_each = local.monitoring

#   zone_id = data.cloudflare_zone.launchspaceport_io.id
#   name    = each.key
#   value   = data.kubernetes_ingress_v1.monitoring[(each.key)].status.0.load_balancer.0.ingress.0.ip
#   type    = "A"
#   ttl     = 1
#   proxied = true

#   depends_on = [helm_release.prometheus_stack, helm_release.loki_stack]
# }

resource "helm_release" "prometheus_stack" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "41.7.3"
  namespace  = var.monitoring_namespace

  set {
    name  = "grafana.image.tag"
    value = "9.2.1"
  }

  set {
    name  = "grafana.adminPassword"
    value = var.grafana_password
  }

  values = [templatefile("config/values.tftpl", {
    alertmanager_url      = var.alertmanager_url
    prometheus_url        = var.prometheus_url
    grafana_url           = var.grafana_url
    grafana_client_id     = var.grafana_github_oauth_client_id
    grafana_client_secret = var.grafana_github_oauth_client_secret
  })]

  depends_on = [kubernetes_config_map.grafana_dashboards]
}

resource "helm_release" "oauth2_proxy_monitoring" {
  for_each = local.oauth2_proxy

  name       = "oauth2-proxy-${each.key}"
  repository = "https://oauth2-proxy.github.io/manifests"
  chart      = "oauth2-proxy"
  version    = "6.2.2"
  namespace  = var.monitoring_namespace

  set {
    name  = "config.clientID"
    value = each.value.client_id
  }

  set {
    name  = "config.clientSecret"
    value = each.value.client_secret
  }

  set {
    name  = "extraArgs.scope"
    value = "user:email read:org"
  }

  set {
    name  = "extraArgs.github-org"
    value = "spaceport-near"
  }

  set {
    name  = "extraArgs.provider"
    value = "github"
  }

  set {
    name  = "extraArgs.redirect-url"
    value = "https://${each.value.host_url}/oauth2/callback"
  }

  values = [templatefile("config/oauth2_proxy.tftpl", {
    host_url = each.value.host_url
  })]
}

resource "helm_release" "loki_stack" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.8.3"
  namespace  = var.monitoring_namespace

  set {
    name  = "loki.persistence.enabled"
    value = "true"
  }

  set {
    name  = "loki.persistence.size"
    value = "50Gi"
  }

  set {
    name  = "loki.persistence.storageClassName"
    value = "do-block-storage"
  }
}
