# Component 1: Infrastructure (Linode compute, networking, DNS)
component "infrastructure" {
  source = "./components/infrastructure"

  inputs = {
    environment                 = var.environment
    region                      = var.region
    instance_type               = var.instance_type
    rke2_version                = var.rke2_version
    rancher_hostname            = var.rancher_hostname
    cloudflare_zone_name        = var.cloudflare_zone_name
    vpc_label                   = var.vpc_label
    vpc_subnet_label            = var.vpc_subnet_label
    vpc_subnet_ipv4             = var.vpc_subnet_ipv4
    tags                        = var.tags
  }

  providers = {
    linode     = provider.linode.main
    cloudflare = provider.cloudflare.main
    random     = provider.random.main
    tls        = provider.tls.main
  }
}

# Component 2: RKE2 (Install and configure RKE2)
component "rke2" {
  source = "./components/rke2"

  inputs = {
    instance_id     = component.infrastructure.instance_id
    instance_ip     = component.infrastructure.instance_ip
    ssh_private_key = component.infrastructure.ssh_private_key
  }

  providers = {
    null     = provider.null.main
    external = provider.external.main
  }
}

# Component 3: Rancher Server (Deploy Rancher via Helm)
component "rancher_server" {
  source = "./components/rancher-server"

  depends_on = [component.rke2]

  inputs = {
    rancher_hostname     = var.rancher_hostname
    rancher_version      = var.rancher_version
    cert_manager_version = var.cert_manager_version
    letsencrypt_email    = var.letsencrypt_email
  }

  providers = {
    helm               = provider.helm.main
    kubernetes         = provider.kubernetes.main
    rancher2.bootstrap = provider.rancher2.bootstrap
    random             = provider.random.main
  }
}

# Component 4: Rancher Auth (Configure external auth and role bindings)
component "rancher_auth" {
  source = "./components/rancher-auth"

  depends_on = [component.rancher_server]

  inputs = {
    enable_github_oauth  = var.enable_github_oauth
    github_client_id     = var.github_client_id
    github_client_secret = var.github_client_secret
  }

  providers = {
    github   = provider.github.main
    rancher2 = provider.rancher2.main
  }
}
