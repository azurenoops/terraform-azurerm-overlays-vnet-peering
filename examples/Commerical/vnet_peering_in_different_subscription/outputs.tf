# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

output "vnet_peer_1_id" {
  value       = azurerm_virtual_network.vnet1-peering-vnet.id
  description = "The id of the newly created virtual network peering in on first virtual netowork."
}

output "vnet_peer_2_id" {
  value       = azurerm_virtual_network.vnet2-peering-vnet.id
  description = "The id of the newly created virtual network peering in on second virtual netowork."
}

output "vnet_peer_1_name" {
  value       = azurerm_virtual_network.vnet1-peering-vnet.name
  description = "The name of the newly created virtual network peering in on first virtual netowork."
}

output "vnet_peer_2_name" {
  value       = azurerm_virtual_network.vnet2-peering-vnet.name
  description = "The name of the newly created virtual network peering in on second virtual netowork."
}