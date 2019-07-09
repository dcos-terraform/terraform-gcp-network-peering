variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "local_network_name" {
  description = "Local network name, used for naming the peering"
  type        = "string"
}

variable "local_network_self_link" {
  description = "Local network self_link"
  type        = "string"
}

variable "remote_network_name" {
  description = "Remote network name, used for naming the peering"
  type        = "string"
}

variable "remote_network_self_link" {
  description = "Remote network self_link"
  type        = "string"
}
