# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "mod_vnet_peerring" {
  #source  = "azurenoops/overlays-vnet-peering/azurerm"
  #version = "x.x.x"
  source = "../../.."

  # Resource Group, location, VNet and Subnet details
  location           = var.location
  deploy_environment = var.deploy_environment
  environment        = var.environment
  org_name           = var.org_name
  workload_name      = var.workload_name

  # Vnet Peerings details
  enable_different_subscription_peering      = true
  resource_group_1_name                      = azurerm_resource_group.vnet1-peering-network-rg.name
  different_subscription_resource_group_name = azurerm_resource_group.vnet2-peering-network-rg.name

  alias_subscription_id            = "d8385cbe-d2c3-4042-b48c-d1d8bf6e5e06"
  vnet_1_name                      = azurerm_virtual_network.vnet1-peering-vnet.name
  vnet_1_id                        = azurerm_virtual_network.vnet1-peering-vnet.id
  different_subscription_vnet_name = azurerm_virtual_network.vnet2-peering-vnet.name
  different_subscription_vnet_id   = azurerm_virtual_network.vnet2-peering-vnet.id
}
