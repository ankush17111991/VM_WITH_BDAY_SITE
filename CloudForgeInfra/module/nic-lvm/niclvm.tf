variable "niclvm" {}
data "azurerm_subnet" "kasubnet01" {
   name                 = "kasubnet"
  virtual_network_name = "kavnet"
  resource_group_name  = "karg001"
}

resource "azurerm_network_interface" "kanic01" {
    for_each = var.niclvm
    name = each.value.nic_name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    
    ip_configuration {
      subnet_id = data.azurerm_subnet.kasubnet01.id
      name = "internal"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.pipka[each.key].id
    }  
}
resource "azurerm_linux_virtual_machine" "kalvm" {
    for_each = var.niclvm
    name = each.value.lvmname
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    disable_password_authentication = false
    admin_username = "ankushadmin"
    admin_password = each.value.admin_password
    size = "Standard_D2as_v5"
    network_interface_ids = [
        azurerm_network_interface.kanic01[each.key].id,
    ]
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

resource "azurerm_public_ip" "pipka" {
  for_each = var.niclvm
  name                = "acceptanceTestPublicIp1"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"

}

resource "azurerm_network_security_group" "kalvm_nsg" {
  name                = "kalvm-nsg"
  location            = "Japan East"
  resource_group_name = "karg001"

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
  name                       = "Allow-HTTP"
  priority                   = 110
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}

}

resource "azurerm_network_interface_security_group_association" "kalvm_nic_nsg" {
  for_each = var.niclvm

  network_interface_id      = azurerm_network_interface.kanic01[each.key].id
  network_security_group_id = azurerm_network_security_group.kalvm_nsg.id
}


  
