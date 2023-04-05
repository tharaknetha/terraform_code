resource "azurerm_resource_group" "resource_gp" {
  name     = var.az_resource_group_name
  location = var.az_resource_group_location
}
