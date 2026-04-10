identity_token "tfc" {
  audience = ["tfc.workload.identity"]
}

store "varset" "stage_linode" {
  name     = "Linode Credentials - Staging"
  category = "terraform"
}

store "varset" "stage_cloudflare" {
  name     = "Cloudflare Credentials - Development"
  category = "terraform"
}

store "varset" "stage_github" {
  name     = "GitHub Credentials - Development"
  category = "terraform"
}

store "varset" "stage_github_oauth" {
  name     = "GitHub OAuth - Rancher (staging)"
  category = "terraform"
}

store "varset" "prod_linode" {
  name     = "Linode Credentials - Production"
  category = "terraform"
}

store "varset" "prod_cloudflare" {
  name     = "Cloudflare Credentials - Production"
  category = "terraform"
}

deployment "stage" {
  destroy = false

  inputs = {
    # Environment configuration
    environment          = "stage"
    region               = "us-ord"         # Chicago, IL
    instance_type        = "g6-standard-4"  # 4 vCPUs, 8GB RAM
    rancher_hostname     = "rancher-stage-v2.etdevs.com"
    cloudflare_zone_name = "etdevs.com"
    vpc_label            = "default-stage"
    vpc_subnet_label     = "default"
    vpc_subnet_ipv4      = "10.50.0.0/24"

    # Software versions (Phase 2: latest stable compatible set per Rancher matrix)
    rke2_version         = "v1.34.5+rke2r1"
    rancher_version      = "v2.14.0"
    cert_manager_version = "v1.20.0"

    # Rancher configuration
    letsencrypt_email = "dustin@elegantthemes.com"

    # GitHub OAuth (optional)
    enable_github_oauth  = true
    github_client_id     = store.varset.stage_github_oauth.stable.github_client_id
    github_client_secret = store.varset.stage_github_oauth.stable.github_client_secret

    # Tags
    tags = {
      environment = "staging"
      managed-by  = "terraform-cloud-stacks"
      stack       = "rancher"
      purpose     = "management-cluster"
      migration   = "rke1-to-rke2"
    }

    # Provider tokens
    linode_token     = store.varset.stage_linode.linode_token
    cloudflare_token = store.varset.stage_cloudflare.cloudflare_token
    github_token     = store.varset.stage_github.github_token
  }
}

publish_output "stage_rancher_url" {
  description = "Staging Rancher server URL"
  value       = deployment.stage.rancher_url
}

publish_output "stage_rancher_token" {
  description = "Staging Rancher admin API token"
  value       = deployment.stage.rancher_token
}

publish_output "stage_vpc_subnet_id" {
  description = "Shared staging VPC subnet ID for workload nodes"
  value       = deployment.stage.vpc_subnet_id
}

publish_output "stage_vpc_subnet_ipv4" {
  description = "Shared staging VPC subnet IPv4 CIDR for workload nodes"
  value       = deployment.stage.vpc_subnet_ipv4
}

publish_output "stage_vpc_firewall_id" {
  description = "Shared staging VPC firewall ID for workload nodes"
  value       = deployment.stage.vpc_firewall_id
}

# deployment "prod" {
#   inputs = {
#     # Environment configuration
#     environment          = "prod"
#     region               = "us-ord"        # Chicago, IL
#     instance_type        = "g6-standard-4" # 4 vCPUs, 8GB RAM
#     rancher_hostname     = "rancher-v2.elegantthemes.com"
#     cloudflare_zone_name = "elegantthemes.com"
#
#     # Software versions
#     rke2_version         = "v1.30.5+rke2r1"
#     rancher_version      = "2.13.1"
#     cert_manager_version = "v1.16.2"
#
#     # Rancher configuration
#     letsencrypt_email = "dustin@elegantthemes.com"
#
#     # GitHub OAuth (optional)
#     enable_github_oauth = false
#
#     # Tags
#     tags = {
#       environment = "production"
#       managed-by  = "terraform-cloud-stacks"
#       stack       = "rancher"
#       purpose     = "management-cluster"
#       migration   = "rke1-to-rke2"
#     }
#
#     # Provider tokens
#     linode_token     = store.varset.prod_linode.linode_token
#     cloudflare_token = store.varset.prod_cloudflare.cloudflare_token
#     github_token     = store.varset.stage_github.github_token
#   }
# }
