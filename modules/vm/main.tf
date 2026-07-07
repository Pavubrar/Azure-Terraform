
#====Public IP==#
resource "azurerm_public_ip" "vm" {
  name                = "${var.vm_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"
}
#===NIC====#

resource "azurerm_network_interface" "vm" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.vm.id
  }
}

#====Linux VM create====#
resource "azurerm_linux_virtual_machine" "vm" {

  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location

  size = "Standard_B1s"

  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}