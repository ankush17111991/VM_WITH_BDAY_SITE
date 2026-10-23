resource "azurerm_subnet" "kasubnet01" {
    for_each = var.kasubnet1
    name = each.value.subnet_name
    virtual_network_name = each.value.virtual_network_name
    address_prefixes = each.value.address_prefixes
    resource_group_name = each.value.resource_group_name
  
}
variable "kasubnet1" {}

