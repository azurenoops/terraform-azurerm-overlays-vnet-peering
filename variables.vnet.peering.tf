# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.


####################################
# VNet Src Global Configuration   ##
####################################

variable "enable_vnet_peering" {
  type        = bool
  default     = false
  description = "Set to false to prevent the module from creating any resources."
}

variable "vnet_src_name" {
  type        = string
  default     = ""
  description = "The name of the virtual network. Changing this forces a new resource to be created."
}

variable "vnet_src_id" {
  type        = string
  default     = ""
  description = "The full Azure resource ID of the remote virtual network. Changing this forces a new resource to be created."
}

variable "allow_virtual_network_access" {
  type        = bool
  default     = true
  description = "Controls if the VMs in the remote virtual network can access VMs in the local virtual network."
}

variable "allow_forwarded_traffic_vnet_src" {
  type        = bool
  default     = false
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed"
}

variable "allow_gateway_transit_vnet_src" {
  type        = bool
  default     = false
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network."
}

variable "use_remote_gateways_vnet_src" {
  type        = bool
  default     = false
  description = "Controls if remote gateways can be used on the local virtual network"
}

variable "resource_group_src_name" {
  type        = string
  default     = ""
  description = "The name of srcst existing resource group to be imported."
}

####################################
# VNet Dest Global Configuration  ##
####################################

variable "vnet_dest_id" {
  type        = string
  default     = ""
  description = "The full Azure resource ID of the remote virtual network. Changing this forces a new resource to be created."
}

variable "vnet_dest_name" {
  type        = string
  default     = ""
  description = "The name of the remote virtual network."
}

variable "allow_forwarded_traffic_vnet_dest" {
  type        = bool
  default     = false
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed"
}

variable "allow_gateway_transit_vnet_dest" {
  type        = bool
  default     = false
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network."
}

variable "use_remote_gateways_vnet_dest" {
  type        = bool
  default     = false
  description = "Controls if remote gateways can be used on the local virtual network"
}

variable "resource_group_dest_name" {
  type        = string
  default     = ""
  description = "The name of destnd existing resource group to be imported."
}

########################################
# VNet DIff Sub Global Configuration  ##
########################################

variable "peer_to_different_resource_group" {
  type        = bool
  default     = false
  description = "Flag to tell whether peering is to be done in same in resource group or different resource group "
}

variable "enable_different_subscription_peering" {
  type    = bool
  default = false
}
variable "different_subscription_dest_vnet_name" {
  type        = string
  default     = ""
  description = "The name of the remote virtual network."
}
variable "alias_subscription_id" {
  type        = string
  default     = ""
  description = "Alias for remote provider in module."
}
variable "different_subscription_dest_resource_group_name" {
  type        = string
  default     = ""
  description = "The name of remote resource group to be imported."
}

variable "different_subscription_dest_vnet_id" {
  type        = string
  default     = ""
  description = "The id of the remote virtual network."
}

variable "allow_forwarded_traffic_dest_vnet_different_subscription" {
  type        = bool
  default     = false
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed"
}

variable "allow_gateway_transit_dest_vnet_different_subscription" {
  type        = bool
  default     = false
  description = "Controls gatewayLinks can be used in the different subscriptioncription virtual network’s link to the local virtual network."
}

variable "use_remote_gateways_dest_vnet_different_subscription" {
  type        = bool
  default     = false
  description = "Controls if remote gateways can be used on the different subscriptioncription virtual network"
}