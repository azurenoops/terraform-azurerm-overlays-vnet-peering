locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  # Naming convention for the vnet peering
  vnet_peering_src_name = coalesce(
    var.custom_peering_src_name,
    data.azurenoopsutils_resource_name.vnet_peering_src.result,
  )

  vnet_peering_dest_name = coalesce(
    var.custom_peering_dest_name,
   data.azurenoopsutils_resource_name.vnet_peering_dest.result,
  )
}
