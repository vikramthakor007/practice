resource "azurerm_network_interface" "nic" {
  for_each = var.vms

  name                = "nic-${each.key}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.frontend[each.key].id   
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id     
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vms

  name                = each.value.vm_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name 
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  size                            = each.value.size
  disable_password_authentication = false
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

