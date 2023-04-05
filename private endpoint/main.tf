// creating a storage account and blob with private end point 

# resource "azurerm_resource_group" "wiprorg" {
#   name     = "myrg"
#   location = "east us"

# }

# resource "azurerm_virtual_network" "wipvnet" {
#   name                = "myvnet"
#   resource_group_name = azurerm_resource_group.wiprorg.name
#   location            = azurerm_resource_group.wiprorg.location
#   address_space       = ["10.10.0.0/16"]

# }

# resource "azurerm_subnet" "wipsubnet" {
#   name                 = "mysubnet"
#   resource_group_name  = azurerm_resource_group.wiprorg.name
#   virtual_network_name = azurerm_virtual_network.wipvnet.name
#   address_prefixes     = ["10.10.1.0/24"]

# }

# resource "azurerm_storage_account" "wipstoraage" {
#   name                     = "mystroage234532"
#   resource_group_name      = azurerm_resource_group.wiprorg.name
#   location                 = azurerm_resource_group.wiprorg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

# }

# resource "azurerm_storage_container" "wipcontainer" {
#   name                  = "mycontainer"
#   storage_account_name  = azurerm_storage_account.wipstoraage.name
#   container_access_type = "private"

# }

# resource "azurerm_storage_blob" "wipblob" {
#   name                   = "myblob2324"
#   storage_account_name   = azurerm_storage_account.wipstoraage.name
#   storage_container_name = azurerm_storage_container.wipcontainer.name
#   type                   = "Block"

# }

# resource "azurerm_private_endpoint" "wipprivate" {
#   name                = "myprivateendpoint232"
#   resource_group_name = azurerm_resource_group.wiprorg.name
#   location            = azurerm_resource_group.wiprorg.location
#   subnet_id           = azurerm_subnet.wipsubnet.id

#   private_service_connection {
#     name                           = "myprivateendpoint232"
#     private_connection_resource_id = azurerm_storage_account.wipstoraage.id
#     is_manual_connection           = false
#     subresource_names              = ["blob"]
#   }

# }
