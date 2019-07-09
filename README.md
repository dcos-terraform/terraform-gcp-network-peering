[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-network/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-network/job/master/)
#  terraform-gcp-network

Creates a DC/OS network for GCP for Masters and Agents

## EXAMPLE

```hcl
module "dcos-network-peering" {
  source  = "dcos-terraform/network-peering/gcp"
  version = "~> 0.2.0"

  cluster_name             = "${var.cluster_name}"
  local_network_name       = "master"
  local_network_self_link  = "${var.local_network_self_link}"
  remote_network_name      = "use1"
  remote_network_self_link = "${var.remote_network_self_link}"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| local\_network\_name | Local network name, used for naming the peering | string | n/a | yes |
| local\_network\_self\_link | Local network self_link | string | n/a | yes |
| remote\_network\_name | Remote network name, used for naming the peering | string | n/a | yes |
| remote\_network\_self\_link | Remote network self_link | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| peering\_state\_details\_local | Local peering state details |
| peering\_state\_details\_remote | Remote peering state details |
| peering\_state\_local | Local peering state |
| peering\_state\_remote | Remote peering state |

