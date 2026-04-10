component "infrastructure" {
  source = "./components/infrastructure"

  inputs = {
    environment         = var.environment
    region              = var.region
    backup_bucket_label = var.backup_bucket_label
  }

  providers = {
    linode = provider.linode.main
  }
}

component "workload_cluster" {
  source = "./components/workload-cluster"

  depends_on = [component.infrastructure]

  inputs = {
    environment                 = var.environment
    region                      = var.region
    cluster_name                = var.cluster_name
    kubernetes_version          = var.kubernetes_version
    cni                         = var.cni
    control_plane_instance_type = var.control_plane_instance_type
    worker_instance_type        = var.worker_instance_type
    screenshot_instance_type    = var.screenshot_instance_type
    control_plane_count         = var.control_plane_count
    worker_count                = var.worker_count
    screenshot_count            = var.screenshot_count
    linode_image                = var.linode_image
    ssh_port                    = var.ssh_port
    bootstrap_generation        = var.bootstrap_generation
    vpc_subnet_id               = var.vpc_subnet_id
    vpc_subnet_ipv4             = var.vpc_subnet_ipv4
    vpc_firewall_id             = var.vpc_firewall_id
    backup_bucket_name          = component.infrastructure.backup_bucket_name
    backup_bucket_endpoint      = component.infrastructure.backup_bucket_endpoint
    backup_bucket_region        = component.infrastructure.backup_bucket_region
    backup_access_key           = component.infrastructure.backup_access_key
    backup_secret_key           = component.infrastructure.backup_secret_key
    linode_token                = var.linode_token
  }

  providers = {
    cloudflare = provider.cloudflare.main
    random     = provider.random.main
    rancher2   = provider.rancher2.main
  }
}

component "platform_services" {
  source = "./components/platform-services"

  depends_on = [component.workload_cluster]

  inputs = {
    cluster_id                        = component.workload_cluster.cluster_id
    system_project_id                 = component.workload_cluster.system_project_id
    region                            = var.region
    rancher_url                       = var.rancher_url
    vpc_subnet_id                     = var.vpc_subnet_id
    cloudflare_email                  = var.cloudflare_email
    cloudflare_token                  = var.cloudflare_token
    letsencrypt_email                 = var.letsencrypt_email
    alert_slack_api_url               = var.alert_slack_api_url
    cert_manager_chart_version        = var.cert_manager_chart_version
    rancher_monitoring_chart_version  = var.rancher_monitoring_chart_version
    linode_ccm_chart_version          = var.linode_ccm_chart_version
    linode_csi_chart_version          = var.linode_csi_chart_version
    monitoring_view_group_principals  = var.monitoring_view_group_principals
    linode_token                      = var.linode_token
  }

  providers = {
    github     = provider.github.main
    kubernetes = provider.kubernetes.main
    random     = provider.random.main
    rancher2   = provider.rancher2.main
  }
}
