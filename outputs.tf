output "local_peering_state" {
  description = "Local peering state"
  value       = google_compute_network_peering.local.state
}

output "local_peering_state_details" {
  description = "Local peering state details"
  value       = google_compute_network_peering.local.state_details
}

output "remote_peering_state" {
  description = "Remote peering state"
  value       = google_compute_network_peering.remote.state
}

output "remote_peering_state_details" {
  description = "Remote peering state details"
  value       = google_compute_network_peering.remote.state_details
}

output "peering_resource_id" {
  description = "Peering ID for null_resource triggers usage on additional peering module calls"
  value       = null_resource.dummy_dependency.id
}

