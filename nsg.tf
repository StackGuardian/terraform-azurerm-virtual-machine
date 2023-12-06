resource "azurerm_network_security_group" "nsg" {
  location            = var.location
  name                = "nsg-${random_id.id.hex}"
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.create_public_ip ? ["ssh"] : []

    content {
      access                     = "Allow"
      direction                  = "Inbound"
      name                       = "ssh"
      priority                   = 200
      protocol                   = "Tcp"
      destination_address_prefix = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
  }
}
