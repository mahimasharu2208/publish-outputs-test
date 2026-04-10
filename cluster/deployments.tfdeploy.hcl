identity_token "tfc" {
  audience = ["tfc.workload.identity"]
}

upstream_input "rancher_stack" {
  type   = "stack"
  source = "app.terraform.io/elegantthemes/Cloud Infrastructure/Rancher"
}

store "varset" "stage_linode" {
  name     = "Linode Credentials - Staging"
  category = "terraform"
}

store "varset" "stage_cloudflare" {
  name     = "Cloudflare Credentials - Development"
  category = "terraform"
}

store "varset" "stage_monitoring" {
  name     = "Monitoring"
  category = "terraform"
}

store "varset" "stage_github" {
  name     = "GitHub Credentials - Development"
  category = "terraform"
}

deployment "stage" {
  inputs = {
    environment        = "stage"
    region             = "us-ord"
    cluster_name       = "k8s-cluster-stage-v2"
    kubernetes_version = "v1.34.5+rke2r1"

    control_plane_instance_type = "g6-standard-4"
    worker_instance_type        = "g6-standard-6"
    screenshot_instance_type    = "g6-standard-4"

    control_plane_count = 1
    worker_count        = 3
    screenshot_count    = 1

    linode_image         = "private/37642409"
    ssh_port             = 2292
    bootstrap_generation = 0

    vpc_subnet_id   = upstream_input.rancher_stack.stage_vpc_subnet_id
    vpc_subnet_ipv4 = upstream_input.rancher_stack.stage_vpc_subnet_ipv4
    vpc_firewall_id = upstream_input.rancher_stack.stage_vpc_firewall_id

    backup_bucket_label = "et-k8s-cluster-etcd-backups-stage"

    rancher_url   = upstream_input.rancher_stack.stage_rancher_url
    rancher_token = upstream_input.rancher_stack.stage_rancher_token

    linode_token      = store.varset.stage_linode.linode_token
    github_owner      = "elegantthemes"
    github_token      = store.varset.stage_github.github_token
    cloudflare_email  = "dustin@elegantthemes.com"
    cloudflare_token  = store.varset.stage_cloudflare.cloudflare_token
    letsencrypt_email = "dustin@elegantthemes.com"
    alert_slack_api_url = store.varset.stage_monitoring.alert_slack_api_url

    cert_manager_chart_version       = "v1.20.0"
    rancher_monitoring_chart_version = "105.1.0+up61.3.2"
    linode_ccm_chart_version         = "v0.9.5"
    linode_csi_chart_version         = "v1.1.1"

    monitoring_view_group_principals = []

  }
}

# deployment "prod" {
#   inputs = {
#     environment        = "prod"
#     region             = "us-ord"
#     cluster_name       = "k8s-cluster-prod-v2"
#     kubernetes_version = "v1.34.5+rke2r1"
#   }
# }
