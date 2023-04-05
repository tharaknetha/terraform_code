resource "azurerm_resource_group" "zetarg" {
  name     = "zeta-qat"
  location = "West Europe"
}
// creating a virtual network name

resource "azurerm_virtual_network" "vnet01" {
  name                = "vnet-dev"
  resource_group_name = azurerm_resource_group.zetarg.name
  location            = azurerm_resource_group.zetarg.location
  address_space       = ["10.10.0.0/16"]

}

// creating a subnet

resource "azurerm_subnet" "vnetsub01" {
  name                 = "subnet-dev"
  resource_group_name  = azurerm_resource_group.zetarg.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.10.1.0/24"]
}



//creating a storage account.

resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformstorage12"
  resource_group_name      = azurerm_resource_group.zetarg.name
  location                 = azurerm_resource_group.zetarg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

//  creating a container in the storage account
resource "azurerm_storage_container" "container" {
  name                  = "stroagecontainer"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}


resource "azurerm_recovery_services_vault" "myvault" {
  name                = "stroage-vault"
  location            = azurerm_resource_group.zetarg.location
  resource_group_name = azurerm_resource_group.zetarg.name
  sku                 = "Standard"
}
// creating a azurerm backup container storage account

resource "azurerm_backup_container_storage_account" "container" {
  resource_group_name = azurerm_resource_group.zetarg.name
  recovery_vault_name = azurerm_recovery_services_vault.myvault.name
  storage_account_id  = azurerm_storage_account.storage_account.id
}

//creating a backup policy for file share.

resource "azurerm_backup_policy_file_share" "backuppolicy" {
  name                = "my-recovery-vault-policy"
  resource_group_name = azurerm_resource_group.zetarg.name
  recovery_vault_name = azurerm_recovery_services_vault.myvault.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "22:00"
  }

  retention_daily {
    count = 12
  }

  retention_weekly {
    count    = 9
    weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
  }

  retention_monthly {
    count    = 9
    weekdays = ["Sunday", "Wednesday"]
    weeks    = ["First", "Last"]
  }

  retention_yearly {
    count    = 9
    weekdays = ["Sunday"]
    weeks    = ["Last"]
    months   = ["January"]
  }
}
