# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------------
#  VNet Peering between two virtual networks
#---------------------------------------------------------------

###########################################################
# Enable global peering between the two virtual network  ##
###########################################################
resource "azurerm_virtual_network_peering" "peering" {
  count                        = var.enable_vnet_peering || var.enable_different_subscription_peering ? 1 : 0
  name                         = var.enable_different_subscription_peering == false ? format("%s-peering-%s", var.vnet_1_name, var.vnet_2_name) : format("%s-peering-%s", var.vnet_1_name, var.different_subscription_vnet_name)
  resource_group_name          = var.resource_group_1_name
  virtual_network_name         = var.vnet_1_name
  remote_virtual_network_id    = var.enable_different_subscription_peering == false ? var.vnet_2_id : var.different_subscription_vnet_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic_vnet1
  allow_gateway_transit        = var.allow_gateway_transit_vnet1
  use_remote_gateways          = var.use_remote_gateways_vnet1
}

###########################################################
# Enable global peering between the two virtual network  ##
###########################################################
resource "azurerm_virtual_network_peering" "peering_back" {
  count                        = var.enable_vnet_peering ? 1 : 0
  name                         = format("%s-peering-%s", var.vnet_2_name, var.vnet_1_name)
  resource_group_name          = var.peer_to_different_resource_group ? var.resource_group_2_name : var.resource_group_1_name
  virtual_network_name         = var.vnet_2_name
  remote_virtual_network_id    = var.vnet_1_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic_vnet2
  allow_gateway_transit        = var.allow_gateway_transit_vnet2
  use_remote_gateways          = var.use_remote_gateways_vnet2
}

#####################################################################################
# Enable global peering between the two virtual network in different subscriptions ##
#####################################################################################
resource "azurerm_virtual_network_peering" "peering_back_diff_subscription" {
  provider                     = azurerm.peer
  count                        = var.enable_different_subscription_peering ? 1 : 0
  name                         = format("%s-peering-%s", var.different_subscription_vnet_name, var.vnet_1_name)
  resource_group_name          = var.different_subscription_resource_group_name
  virtual_network_name         = var.different_subscription_vnet_name
  remote_virtual_network_id    = var.vnet_1_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic_vnet_different_subscription
  allow_gateway_transit        = var.allow_gateway_transit_vnet_different_subscription
  use_remote_gateways          = var.use_remote_gateways_vnet_different_subscription
}
