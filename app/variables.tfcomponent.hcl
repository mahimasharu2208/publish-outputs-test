# Environment configuration
variable "environment" {
  type        = string
  description = "Environment name (stage, prod)"
}

variable "region" {
  type        = string
  description = "Linode region for infrastructure"
}

variable "instance_type" {
  type        = string
  description = "Linode instance type"
  default     = "g6-standard-4"
}

# Rancher configuration
variable "rancher_hostname" {
  type        = string
  description = "Full hostname for Rancher server"
}

variable "cloudflare_zone_name" {
  type        = string
  description = "Cloudflare zone name for Rancher DNS record"
}

variable "vpc_label" {
  type        = string
  description = "Linode VPC label for management networking"
}

variable "vpc_subnet_label" {
  type        = string
  description = "Linode VPC subnet label for management networking"
}

variable "vpc_subnet_ipv4" {
  type        = string
  description = "Linode VPC subnet IPv4 CIDR (for example 10.50.0.0/24)"
}

variable "letsencrypt_email" {
  type        = string
  description = "Email for Let's Encrypt certificates"
}

# Software versions
variable "rke2_version" {
  type        = string
  description = "RKE2 version to install"
}

variable "rancher_version" {
  type        = string
  description = "Rancher Helm chart version"
}

variable "cert_manager_version" {
  type        = string
  description = "cert-manager version"
}

# GitHub OAuth (optional)
variable "enable_github_oauth" {
  type        = bool
  description = "Enable GitHub OAuth authentication"
  default     = false
}

variable "github_client_id" {
  type        = string
  description = "GitHub OAuth client ID"
  default     = ""
  sensitive   = true
}

variable "github_client_secret" {
  type        = string
  description = "GitHub OAuth client secret"
  default     = ""
  sensitive   = true
}

variable "github_token" {
  type        = string
  description = "GitHub token for team lookups"
  sensitive   = true
  ephemeral   = true
}

# Tags
variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

# Provider tokens (from TFC variables)
variable "linode_token" {
  type        = string
  description = "Linode API token"
  sensitive   = true
  ephemeral   = true
}

variable "cloudflare_token" {
  type        = string
  description = "Cloudflare API token"
  sensitive   = true
  ephemeral   = true
}
