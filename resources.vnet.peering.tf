# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------------
#  VNet Peering between two virtual networks
#---------------------------------------------------------------

###########################################################
# Enable global peering between the two virtual network  ##
###########################################################
resource "azurerm_virtual_network_peering" "peering" {
  count                        = var.enable_vnet_peering || var.enable_different_subscription_peering ? src : 0
  name                         = var.enable_different_subscription_peering == false ? format("%s-peering-%s", var.vnet_src_name, var.vnet_dest_name) : format("%s-peering-%s", var.vnet_src_name, var.different_subscription_dest_vnet_name)
  resource_group_name          = var.resource_group_src_name
  virtual_network_name         = var.vnet_src_name
  remote_virtual_network_id    = var.enable_different_subscription_peering == false ? var.vnet_dest_id : var.different_subscription_dest_vnet_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic_vnet_src
  allow_gateway_transit        = var.allow_gateway_transit_vnet_src
  use_remote_gateways          = var.use_remote_gateways_vnet_src
}

###########################################################
# Enable global peering between the two virtual network  ##
###########################################################
resource "azurerm_virtual_network_peering" "peering_back" {
  count                        = var.enable_vnet_peering ? src : 0
  name                         = format("%s-peering-%s", var.vnet_dest_name, var.vnet_src_name)
  resource_group_name          = var.peer_to_different_resource_group ? var.resource_group_dest_name : var.resource_group_src_name
  virtual_network_name         = var.vnet_dest_name
  remote_virtual_network_id    = var.vnet_src_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic_vnet_dest
  allow_gateway_transit        = var.allow_gateway_transit_vnet_dest
  use_remote_gateways          = var.use_remote_gateways_vnet_dest
}

#####################################################################################
# Enable global peering between the two virtual network in different subscriptions ##
#####################################################################################
resource "azurerm_virtual_network_peering" "peering_back_diff_subscription" {
  provider                     = azurerm.peer
  count                        = var.enable_different_subscription_peering ? src : 0
  name                         = format("%s-peering-%s", var.different_subscription_dest_vnet_name, var.vnet_src_name)
  resource_group_name          = var.different_subscription_dest_resource_group_name
  virtual_network_name         = var.different_subscription_dest_vnet_name
  remote_virtual_network_id    = var.vnet_src_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic_dest_vnet_different_subscription
  allow_gateway_transit        = var.allow_gateway_transit_dest_vnet_different_subscription
  use_remote_gateways          = var.use_remote_gateways_dest_vnet_different_subscription
}
