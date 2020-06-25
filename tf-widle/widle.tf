provider "azurerm" {
  version = "=2.8.0"
  features { }
}

#create the resource group
resource "azurerm_resource_group" "network-rg" {
  name = "teststack-resource-group"
  location = "westeurope"
}

#create the virtual network
resource "azurerm_virtual_network" "vnet1" {
    resource_group_name = azurerm_resource_group.network-rg.name
    location = "westeurope"
    name = "dev"
    address_space = ["10.0.0.0/16"]
}

#create a subnet within the virtual network
resource "azurerm_subnet" "subnet1" {
    resource_group_name = azurerm_resource_group.network-rg.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    name = "devsubnet"
    address_prefixes = ["10.0.0.0/24"]
}

##create the network interface for the VM
resource "azurerm_public_ip" "pub_ip" {
    name = "vmpubip"
    location = "westeurope"
    resource_group_name = azurerm_resource_group.network-rg.name
    allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "vmnic" {
    location = "westeurope"
    resource_group_name = azurerm_resource_group.network-rg.name
    name = "vmnic1"

    ip_configuration {
        name = "vmnic1-ipconf"
        subnet_id = azurerm_subnet.subnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.pub_ip.id
    }
}


##create the actual VM
resource "azurerm_windows_virtual_machine" "windows-10-vm" {
  name = "widle"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  size = "Standard_D2s_v3"
  admin_username = "pribylak"
  admin_password = "12sipkovaRuzenka@"

  network_interface_ids = [azurerm_network_interface.vmnic.id]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer = "windows-10"
    sku = "19h2-pro-g2"
    version = "latest"
  }

}
##end creating VM