terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
}

provider "azurerm" {
  features { }
}

resource "azurerm_resource_group" "rg-grp" {
  name     = var.resource_group
  location = var.resource_location
}

resource "azurerm_virtual_network" "app_virtual_network" {
  name                = "app-network"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg-grp.name
  location            = var.resource_location
}

resource "azurerm_subnet" "SubnetA" {
  name                 = "SubnetA"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.app_virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [ 
    azurerm_virtual_network.app_virtual_network
   ]
}

resource "azurerm_network_interface" "app_interface" {
  name                = "app-interface"
  location            = var.resource_location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.app_public_ip.id
  }

  depends_on = [ 
    azurerm_virtual_network.app_virtual_network,
    azurerm_public_ip.app_public_ip
   ]
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "linuxvm"
  resource_group_name = var.resource_group
  location            = var.resource_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = ""                              # Removed for security purposes
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.app_interface.id,
  ]

 /*  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  } */

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

  depends_on = [ 
    azurerm_network_interface.app_interface
   ]
} 

resource "azurerm_public_ip" "app_public_ip" {
  name                = "app-public-ip"
  resource_group_name = var.resource_group
  location            = var.resource_location
  allocation_method   = "Static"

  depends_on = [ 
    azurerm_resource_group.rg-grp
   ]
}

# Created NSG so I can make an inbound rule for SSH access port 22
resource "azurerm_network_security_group" "app_nsg" {
  name                = "app-nsg"
  location            = var.resource_location
  resource_group_name = var.resource_group

  # Rule for SSH access
  security_rule {
    name                       = "Allow_SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.my_ip
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.SubnetA.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id

  depends_on = [ 
    azurerm_network_security_group.app_nsg
   ]
}
