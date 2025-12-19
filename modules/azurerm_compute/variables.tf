variable "vms" {
  type = map(object({
    vm_name             = string
    location            = string
    resource_group_name = string
    vnet_name           = string
    subnet_name         = string
    nic_name            = string
    pip_name            = string
    admin_username      = string
    admin_password      = string
    size                = string

    # source_image_reference = object({
    #   publisher = string
    #   offer     = string
    #   sku       = string
    #   version   = string
    # })
  }))
}
