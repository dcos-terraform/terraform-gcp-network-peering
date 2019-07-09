/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-network/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-network/job/master/)
 * #  terraform-gcp-network
 *
 * Creates a DC/OS network for GCP for Masters and Agents
 *
 * ## EXAMPLE
 *
 * ```hcl
 * module "dcos-network-peering" {
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

resource "google_compute_network_peering" "local" {
  provider     = "google.local"
  name         = "${var.cluster_name}-${var.local_network_name}-${var.remote_network_name}"
  network      = "${var.local_network_self_link}"
  peer_network = "${var.remote_network_self_link}"
}

resource "google_compute_network_peering" "remote" {
  provider     = "google.remote"
  name         = "${var.cluster_name}-${var.remote_network_name}-${var.local_network_name}"
  network      = "${var.remote_network_self_link}"
  peer_network = "${var.local_network_self_link}"

  depends_on = ["null_resource.local-remote-state-check"]
}

resource "null_resource" "local-remote-state-check" {
  provisioner "local-exec" {
    command = "echo ${google_compute_network_peering.local.state}"
  }
}
