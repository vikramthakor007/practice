data "azurerm_virtual_network" "vnet" {
  for_each = var.vms

  name                = each.value.vnet_name
  resource_group_name = each.value.resource_group_name   
}

data "azurerm_subnet" "frontend" {
  for_each = var.vms

  name                 = each.value.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet[each.key].name
  resource_group_name  = each.value.resource_group_name  

}

data "azurerm_public_ip" "pip" {
  for_each = var.vms

  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}


