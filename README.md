# Azure VNet Peering Overlay Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![MIT License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/azurenoops/overlays-vnet-peering/azurerm/)

This Overlay terraform module can deploy and manage a Azure VNet peerings and its associated resources. This module can be used in a [SCCA compliant Network](https://registry.terraform.io/modules/azurenoops/overlays-hubspoke/azurerm/latest).

## Using Azure Clouds

Since this module is built for both public and us government clouds. The `environment` variable defaults to `public` for Azure Cloud. When using this module with the Azure Government Cloud, you must set the `environment` variable to `usgovernment`. You will also need to set the azurerm provider `environment` variable to the proper cloud as well. This will ensure that the correct Azure Government Cloud endpoints are used. You will also need to set the `location` variable to a valid Azure Government Cloud location.

Example Usage for Azure Government Cloud:

```hcl

provider "azurerm" {
  environment = "usgovernment"
}

module "mod_ampls" {
  source  = "azurenoops/overlays-vnet-peering/azurerm"
  version = "x.x.x"
  
  location = "usgovvirginia"
  environment = "usgovernment"
  ...
}

```

## SCCA Compliance

This module can be SCCA compliant and can be used in a SCCA compliant Network. Enable private endpoints and SCCA compliant network rules to make it SCCA compliant.

For more information, please read the [SCCA documentation](https://github.com/azurenoops/terraform-azurerm-overlays-compute-image-gallery/blob/main).

## Contributing

If you want to contribute to this repository, feel free to to contribute to our Terraform module.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## License

This Terraform module is open-sourced software licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Resources Supported

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering_back](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering_back_diff_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Module Usage

### VNet Peering in Same Subscriptions

```hcl
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "mod_vnp" {
  source  = "azurenoops/overlays-vnet-peering/azurerm"
  version = "x.x.x"

  depends_on = [azurerm_virtual_network.example-vnet, azurerm_subnet.example-snet, azurerm_log_analytics_workspace.example-log]

  # Resource Group, location, VNet and Subnet details
  location           = var.location
  deploy_environment = var.deploy_environment
  environment        = var.environment
  org_name           = var.org_name
  workload_name      = var.workload_name

  # Vnet Peerings details
  enable_vnet_peering  = true
  resource_group_1_name = azurerm_resource_group.vnet1-peering-network-rg.name
  resource_group_2_name = azurerm_resource_group.vnet2-peering-network-rg.name

  peer_to_different_resource_group    = true
  vnet_src_name                       = azurerm_virtual_network.vnet1-peering-vnet.name
  vnet_src_id                         = azurerm_virtual_network.vnet1-peering-vnet.id
  vnet_dest_name                      = azurerm_virtual_network.vnet2-peering-vnet.name
  vnet_dest_id                        = azurerm_virtual_network.vnet2-peering-vnet.id
}
 ```

### VNet Peering in Different Subscriptions

```hcl
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "mod_vnp" {
  source  = "azurenoops/overlays-vnet-peering/azurerm"
  version = "x.x.x"

  depends_on = [azurerm_virtual_network.example-vnet, azurerm_subnet.example-snet, azurerm_log_analytics_workspace.example-log]

  # Resource Group, location, VNet and Subnet details
  location           = var.location
  deploy_environment = var.deploy_environment
  environment        = var.environment
  org_name           = var.org_name
  workload_name      = var.workload_name

  # Vnet Peerings details
  enable_different_subscription_peering           = true
  resource_group_1_name                           = azurerm_resource_group.vnet1-peering-network-rg.name
  different_subscription_dest_resource_group_name = azurerm_resource_group.vnet2-peering-network-rg.name

  alias_subscription_id                 = "d8xxxxxxxxxxxxxxxxxxxx5e06"
  vnet_src_name                         = azurerm_virtual_network.vnet1-peering-vnet.name
  vnet_src_id                           = azurerm_virtual_network.vnet1-peering-vnet.id
  different_subscription_dest_vnet_name = azurerm_virtual_network.vnet2-peering-vnet.name
  different_subscription_dest_vnet_id   = azurerm_virtual_network.vnet2-peering-vnet.id
}
 ```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurenoopsutils"></a> [azurenoopsutils](#requirement\_azurenoopsutils) | ~> 1.0.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.22 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurenoopsutils"></a> [azurenoopsutils](#provider\_azurenoopsutils) | ~> 1.0.4 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.22 |
| <a name="provider_azurerm.peer"></a> [azurerm.peer](#provider\_azurerm.peer) | ~> 3.22 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mod_azure_region_lookup"></a> [mod\_azure\_region\_lookup](#module\_mod\_azure\_region\_lookup) | azurenoops/overlays-azregions-lookup/azurerm | ~> 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering_back](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering_back_diff_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurenoopsutils_resource_name.vnet_peering_dest](https://registry.terraform.io/providers/azurenoops/azurenoopsutils/latest/docs/data-sources/resource_name) | data source |
| [azurenoopsutils_resource_name.vnet_peering_src](https://registry.terraform.io/providers/azurenoops/azurenoopsutils/latest/docs/data-sources/resource_name) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_tags"></a> [add\_tags](#input\_add\_tags) | Map of custom tags. | `map(string)` | `{}` | no |
| <a name="input_alias_subscription_id"></a> [alias\_subscription\_id](#input\_alias\_subscription\_id) | Alias for remote provider in module. | `string` | `""` | no |
| <a name="input_allow_forwarded_traffic_dest_vnet_different_subscription"></a> [allow\_forwarded\_traffic\_dest\_vnet\_different\_subscription](#input\_allow\_forwarded\_traffic\_dest\_vnet\_different\_subscription) | Controls if forwarded traffic from VMs in the remote virtual network is allowed | `bool` | `false` | no |
| <a name="input_allow_forwarded_traffic_vnet_dest"></a> [allow\_forwarded\_traffic\_vnet\_dest](#input\_allow\_forwarded\_traffic\_vnet\_dest) | Controls if forwarded traffic from VMs in the remote virtual network is allowed | `bool` | `false` | no |
| <a name="input_allow_forwarded_traffic_vnet_src"></a> [allow\_forwarded\_traffic\_vnet\_src](#input\_allow\_forwarded\_traffic\_vnet\_src) | Controls if forwarded traffic from VMs in the remote virtual network is allowed | `bool` | `false` | no |
| <a name="input_allow_gateway_transit_dest_vnet_different_subscription"></a> [allow\_gateway\_transit\_dest\_vnet\_different\_subscription](#input\_allow\_gateway\_transit\_dest\_vnet\_different\_subscription) | Controls gatewayLinks can be used in the different subscriptioncription virtual network’s link to the local virtual network. | `bool` | `false` | no |
| <a name="input_allow_gateway_transit_vnet_dest"></a> [allow\_gateway\_transit\_vnet\_dest](#input\_allow\_gateway\_transit\_vnet\_dest) | Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. | `bool` | `false` | no |
| <a name="input_allow_gateway_transit_vnet_src"></a> [allow\_gateway\_transit\_vnet\_src](#input\_allow\_gateway\_transit\_vnet\_src) | Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. | `bool` | `false` | no |
| <a name="input_allow_virtual_network_access"></a> [allow\_virtual\_network\_access](#input\_allow\_virtual\_network\_access) | Controls if the VMs in the remote virtual network can access VMs in the local virtual network. | `bool` | `true` | no |
| <a name="input_custom_peering_dest_name"></a> [custom\_peering\_dest\_name](#input\_custom\_peering\_dest\_name) | Custom name of the vnet peerings to create | `string` | `""` | no |
| <a name="input_custom_peering_src_name"></a> [custom\_peering\_src\_name](#input\_custom\_peering\_src\_name) | Custom name of the vnet peerings to create | `string` | `""` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_deploy_environment"></a> [deploy\_environment](#input\_deploy\_environment) | Name of the workload's environment | `string` | n/a | yes |
| <a name="input_different_subscription_dest_resource_group_name"></a> [different\_subscription\_dest\_resource\_group\_name](#input\_different\_subscription\_dest\_resource\_group\_name) | The name of remote resource group to be imported. | `string` | `""` | no |
| <a name="input_different_subscription_dest_vnet_id"></a> [different\_subscription\_dest\_vnet\_id](#input\_different\_subscription\_dest\_vnet\_id) | The id of the remote virtual network. | `string` | `""` | no |
| <a name="input_different_subscription_dest_vnet_name"></a> [different\_subscription\_dest\_vnet\_name](#input\_different\_subscription\_dest\_vnet\_name) | The name of the remote virtual network. | `string` | `""` | no |
| <a name="input_enable_different_subscription_peering"></a> [enable\_different\_subscription\_peering](#input\_enable\_different\_subscription\_peering) | n/a | `bool` | `false` | no |
| <a name="input_enable_vnet_peering"></a> [enable\_vnet\_peering](#input\_enable\_vnet\_peering) | Set to false to prevent the module from creating any resources. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Terraform backend environment e.g. public or usgovernment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region in which instance will be hosted | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Optional prefix for the generated name | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Optional suffix for the generated name | `string` | `""` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the organization | `string` | n/a | yes |
| <a name="input_peer_to_different_resource_group"></a> [peer\_to\_different\_resource\_group](#input\_peer\_to\_different\_resource\_group) | Flag to tell whether peering is to be done in same in resource group or different resource group | `bool` | `false` | no |
| <a name="input_resource_group_dest_name"></a> [resource\_group\_dest\_name](#input\_resource\_group\_dest\_name) | The name of destnd existing resource group to be imported. | `string` | `""` | no |
| <a name="input_resource_group_src_name"></a> [resource\_group\_src\_name](#input\_resource\_group\_src\_name) | The name of srcst existing resource group to be imported. | `string` | `""` | no |
| <a name="input_use_location_short_name"></a> [use\_location\_short\_name](#input\_use\_location\_short\_name) | Use short location name for resources naming (ie eastus -> eus). Default is true. If set to false, the full cli location name will be used. if custom naming is set, this variable will be ignored. | `bool` | `true` | no |
| <a name="input_use_naming"></a> [use\_naming](#input\_use\_naming) | Use the Azure NoOps naming provider to generate default resource name. `storage_account_custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| <a name="input_use_remote_gateways_dest_vnet_different_subscription"></a> [use\_remote\_gateways\_dest\_vnet\_different\_subscription](#input\_use\_remote\_gateways\_dest\_vnet\_different\_subscription) | Controls if remote gateways can be used on the different subscriptioncription virtual network | `bool` | `false` | no |
| <a name="input_use_remote_gateways_vnet_dest"></a> [use\_remote\_gateways\_vnet\_dest](#input\_use\_remote\_gateways\_vnet\_dest) | Controls if remote gateways can be used on the local virtual network | `bool` | `false` | no |
| <a name="input_use_remote_gateways_vnet_src"></a> [use\_remote\_gateways\_vnet\_src](#input\_use\_remote\_gateways\_vnet\_src) | Controls if remote gateways can be used on the local virtual network | `bool` | `false` | no |
| <a name="input_vnet_dest_id"></a> [vnet\_dest\_id](#input\_vnet\_dest\_id) | The full Azure resource ID of the remote virtual network. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_vnet_dest_name"></a> [vnet\_dest\_name](#input\_vnet\_dest\_name) | The name of the remote virtual network. | `string` | `""` | no |
| <a name="input_vnet_src_id"></a> [vnet\_src\_id](#input\_vnet\_src\_id) | The full Azure resource ID of the remote virtual network. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_vnet_src_name"></a> [vnet\_src\_name](#input\_vnet\_src\_name) | The name of the virtual network. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | Name of the workload\_name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_peer_1_id"></a> [vnet\_peer\_1\_id](#output\_vnet\_peer\_1\_id) | The id of the newly created virtual network peering in on first virtual netowork. |
| <a name="output_vnet_peer_1_name"></a> [vnet\_peer\_1\_name](#output\_vnet\_peer\_1\_name) | The name of the newly created virtual network peering in on first virtual netowork. |
| <a name="output_vnet_peer_2_id"></a> [vnet\_peer\_2\_id](#output\_vnet\_peer\_2\_id) | The id of the newly created virtual network peering in on second virtual netowork. |
| <a name="output_vnet_peer_2_name"></a> [vnet\_peer\_2\_name](#output\_vnet\_peer\_2\_name) | The name of the newly created virtual network peering in on second virtual netowork. |
| <a name="output_vnet_peer_diff_subscription_id"></a> [vnet\_peer\_diff\_subscription\_id](#output\_vnet\_peer\_diff\_subscription\_id) | The id of the newly created virtual network peering in on different subscription virtual netowork. |
| <a name="output_vnet_peer_diff_subscription_name"></a> [vnet\_peer\_diff\_subscription\_name](#output\_vnet\_peer\_diff\_subscription\_name) | The name of the newly created virtual network peering in on different subscription virtual netowork. |
<!-- END_TF_DOCS -->