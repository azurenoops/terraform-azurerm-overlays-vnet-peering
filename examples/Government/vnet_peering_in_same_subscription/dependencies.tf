# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

resource "azurerm_resource_group" "vnet1-peering-network-rg" {
  name     = "vnet1-peering-network-rg"
  location = var.location
  tags = {
    environment = "test"
  }
}

resource "azurerm_resource_group" "vnet2-peering-network-rg" {
  name     = "vnet2-peering-network-rg"
  location = var.location
  tags = {
    environment = "test"
  }
}

resource "azurerm_virtual_network" "vnet1-peering-vnet" {
  depends_on = [
    azurerm_resource_group.vnet1-peering-network-rg
  ]
  name                = "vnet1-peering-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet1-peering-network-rg.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "test"
  }
}

resource "azurerm_virtual_network" "vnet2-peering-vnet" {
  depends_on = [
    azurerm_resource_group.vnet2-peering-network-rg
  ]
  name                = "vnet2-peering-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet2-peering-network-rg.name
  address_space       = ["20.0.0.0/16"]
  tags = {
    environment = "test"
  }
}
