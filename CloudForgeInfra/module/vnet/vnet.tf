resource "azurerm_virtual_network" "kavnet01" {
    for_each = var.kavnet1
    name = each.value.virtual_network_name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    address_space = each.value.address_space
  
}
variable "kavnet1" {}