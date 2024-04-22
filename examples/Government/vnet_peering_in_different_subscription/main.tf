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
  enable_different_subscription_peering           = true
  resource_group_src_name                         = azurerm_resource_group.vnet1-peering-network-rg.name
  different_subscription_dest_resource_group_name = azurerm_resource_group.vnet2-peering-network-rg.name

  alias_subscription_id                 = "d83xxxxxxxxxxxxxxxxxxxxx5e06"
  vnet_src_name                         = azurerm_virtual_network.vnet1-peering-vnet.name
  vnet_src_id                           = azurerm_virtual_network.vnet1-peering-vnet.id
  different_subscription_dest_vnet_name = azurerm_virtual_network.vnet2-peering-vnet.name
  different_subscription_dest_vnet_id   = azurerm_virtual_network.vnet2-peering-vnet.id
}
