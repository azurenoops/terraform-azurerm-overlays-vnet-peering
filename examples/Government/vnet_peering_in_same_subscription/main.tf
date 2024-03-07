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
  enable_vnet_peering  = true
  resource_group_1_name = azurerm_resource_group.vnet1-peering-network-rg.name
  resource_group_2_name = azurerm_resource_group.vnet2-peering-network-rg.name

  peer_to_different_resource_group = true
  vnet_1_name                      = azurerm_virtual_network.vnet1-peering-vnet.name
  vnet_1_id                        = azurerm_virtual_network.vnet1-peering-vnet.id
  vnet_2_name                      = azurerm_virtual_network.vnet2-peering-vnet.name
  vnet_2_id                        = azurerm_virtual_network.vnet2-peering-vnet.id
}
