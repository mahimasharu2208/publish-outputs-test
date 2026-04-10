output "rancher_url" {
  type        = string
  description = "Rancher Server URL"
  value       = component.rancher_server.rancher_url
}

output "rancher_token" {
  type        = string
  description = "Rancher admin API token"
  value       = component.rancher_server.rancher_token
  sensitive   = true
}

output "vpc_subnet_id" {
  type        = string
  description = "Shared VPC subnet ID for Rancher-managed workload nodes"
  value       = component.infrastructure.vpc_subnet_id
}

output "vpc_subnet_ipv4" {
  type        = string
  description = "Shared VPC subnet IPv4 CIDR for Rancher-managed workload nodes"
  value       = component.infrastructure.vpc_subnet_ipv4
}

output "vpc_firewall_id" {
  type        = string
  description = "Shared VPC firewall ID for Rancher-managed workload nodes"
  value       = component.infrastructure.vpc_firewall_id
}
