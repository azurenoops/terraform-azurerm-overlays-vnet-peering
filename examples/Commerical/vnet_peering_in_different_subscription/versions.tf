# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Azurerm provider configuration
provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "mgmt"
  features {}
  subscription_id = "d8385cbe-d2c3-4042-b48c-d1d8bf6e5e06"
}