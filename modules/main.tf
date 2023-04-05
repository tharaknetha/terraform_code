module "resource-Group" {
  source                     = "./RG"
  az_resource_group_name     = "dev-rg"
  az_resource_group_location = "eastus"

}

module "virtual-network" {
  source                        = "./Vnet"
  az_virtual_network            = "dev-vnet"
  az_resource_group_name        = module.resource-Group.az_resource_group_name_out
  az_resource_group_location    = "eastus"
  az_resource_group_adders_spac = ["10.10.0.0/16"]
}
