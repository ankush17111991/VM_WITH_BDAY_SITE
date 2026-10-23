resource "azurerm_resource_group" "karag01" {
    for_each = var.karag1
    name = each.value.resource_group_name
    location = each.value.location  
}
variable "karag1" {}