resource "azurerm_nat_gateway" "example" {
  name                    = "nat-gateway"
  location                = "Japan East"
  resource_group_name     = "karg001"
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}
