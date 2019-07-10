output "peering_state_local" {
  description = "Local peering state"
  value       = "${google_compute_network_peering.local.state}"
}

output "peering_state_details_local" {
  description = "Local peering state details"
  value       = "${google_compute_network_peering.local.state_details}"
}

output "peering_state_remote" {
  description = "Remote peering state"
  value       = "${google_compute_network_peering.remote.state}"
}

output "peering_state_details_remote" {
  description = "Remote peering state details"
  value       = "${google_compute_network_peering.remote.state_details}"
}

output "depends_id" {
  description = "Peering ID for null_resource triggers usage on additional peering module calls"
  value       = "${null_resource.dummy_dependency.id}"
}
