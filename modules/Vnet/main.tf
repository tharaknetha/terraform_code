resource "azurerm_virtual_network" "vnet" {
  name                = var.az_virtual_network
  resource_group_name = var.az_resource_group_name
  location            = var.az_resource_group_location
  address_space       = var.az_resource_group_adders_spac

}
