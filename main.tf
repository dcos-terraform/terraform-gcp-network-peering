/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/buildStatus/icon?job=dcos-terraform%2Fterraform-gcp-network-peering%2Fsupport%252F0.2.x)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-network-peering/job/support%252F0.2.x/)
 *
 * GCP Network Peering
 * =============================
 *
 * Creates a GCP network peering between two networks, autocreates routes
 *
 * EXAMPLE
 * -------
 *
 * ```hcl
 * module "network-peering" {
 *   source  = "dcos-terraform/network-peering/gcp"
 *   version = "~> 0.2.0"
 *
 *   cluster_name             = "${var.cluster_name}"
 *   local_network_name       = "master"
 *   local_network_self_link  = "${var.local_network_self_link}"
 *   remote_network_name      = "use1"
 *   remote_network_self_link = "${var.remote_network_self_link}"
 * }
 * ```
 */

provider "google" {
  alias = "local"
}

provider "google" {
  alias = "remote"
}

# adding a null resource with triggers to wait for another VPC peering if the variable
# `wait_for_peering_id` is set or changed.
resource "null_resource" "wait_for_peering" {
  triggers = {
    depends_id = var.wait_for_peering_id
  }
}

resource "google_compute_network_peering" "local" {
  provider     = google.local
  name         = "${var.cluster_name}-${var.local_network_name}-${var.remote_network_name}"
  network      = var.local_network_self_link
  peer_network = var.remote_network_self_link

  depends_on = [null_resource.wait_for_peering]
}

resource "google_compute_network_peering" "remote" {
  provider     = google.remote
  name         = "${var.cluster_name}-${var.remote_network_name}-${var.local_network_name}"
  network      = var.remote_network_self_link
  peer_network = var.local_network_self_link

  depends_on = [google_compute_network_peering.local]
}

# output a null resource as dummy dependency, to have a reusable id for another peering
# that would need to wait for this VPC peering module call. See `waiting_for_peering` above.
resource "null_resource" "dummy_dependency" {
  depends_on = [google_compute_network_peering.remote]
}

