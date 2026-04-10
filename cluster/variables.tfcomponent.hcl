variable "environment" {
  type        = string
  description = "Environment name (stage, prod)"
}

variable "region" {
  type        = string
  description = "Linode region for workload infrastructure"
}

variable "cluster_name" {
  type        = string
  description = "Rancher-managed workload cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "RKE2 Kubernetes version for the workload cluster"
}

variable "cni" {
  type        = list(string)
  description = "RKE2 CNI order"
  default     = ["multus", "canal"]
}

variable "control_plane_instance_type" {
  type        = string
  description = "Linode instance type for control plane nodes"
}

variable "worker_instance_type" {
  type        = string
  description = "Linode instance type for general workload nodes"
}

variable "screenshot_instance_type" {
  type        = string
  description = "Linode instance type for screenshot workload nodes"
}

variable "control_plane_count" {
  type        = number
  description = "Control plane node count"
}

variable "worker_count" {
  type        = number
  description = "Worker node count"
}

variable "screenshot_count" {
  type        = number
  description = "Screenshot node count"
}

variable "linode_image" {
  type        = string
  description = "Linode image to use for workload nodes"
}

variable "ssh_port" {
  type        = number
  description = "SSH port configured on workload nodes"
  default     = 2292
}

variable "bootstrap_generation" {
  type        = number
  description = "Bump to force workload node replacement when bootstrap user_data changes must be reapplied"
  default     = 0
}

variable "vpc_subnet_id" {
  type        = string
  description = "Shared Rancher VPC subnet ID reused by workload nodes"
}

variable "vpc_subnet_ipv4" {
  type        = string
  description = "Shared Rancher VPC subnet IPv4 CIDR reused by workload nodes"
}

variable "vpc_firewall_id" {
  type        = string
  description = "Shared Rancher VPC firewall ID reused by workload nodes"
}

variable "backup_bucket_label" {
  type        = string
  description = "Base label for the workload-cluster etcd backup bucket"
}

variable "rancher_url" {
  type        = string
  description = "Rancher API URL"
}

variable "rancher_token" {
  type        = string
  description = "Rancher API token"
  sensitive   = true
}

variable "linode_token" {
  type        = string
  description = "Linode API token"
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "GitHub organization that owns Rancher access-control teams"
}

variable "github_token" {
  type        = string
  description = "GitHub API token used to resolve Rancher access-control teams"
  sensitive   = true
}

variable "cloudflare_email" {
  type        = string
  description = "Cloudflare account email for ACME DNS challenges"
}

variable "cloudflare_token" {
  type        = string
  description = "Cloudflare API token for ACME DNS challenges"
  sensitive   = true
}

variable "letsencrypt_email" {
  type        = string
  description = "Email address for Let's Encrypt registration"
}

variable "alert_slack_api_url" {
  type        = string
  description = "Slack webhook URL used by Alertmanager"
  default     = ""
}

variable "cert_manager_chart_version" {
  type        = string
  description = "cert-manager chart version"
}

variable "rancher_monitoring_chart_version" {
  type        = string
  description = "rancher-monitoring chart version"
}

variable "linode_ccm_chart_version" {
  type        = string
  description = "Linode CCM chart version"
}

variable "linode_csi_chart_version" {
  type        = string
  description = "Linode Block Storage CSI chart version"
}

variable "monitoring_view_group_principals" {
  type        = list(string)
  description = "Additional Rancher group principals allowed to view monitoring dashboards"
  default     = []
}
