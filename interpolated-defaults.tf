data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

locals {
  name                        = var.name != null ? var.name : "${var.product}-${var.component}"
  is_prod                     = length(regexall(".*(prod).*", var.env)) > 0
  managed_resource_group_name = var.managed_resource_group_name == null ? "${local.name}-managed-rg" : var.managed_resource_group_name
  resource_group              = var.existing_resource_group_name == null ? azurerm_resource_group.new[0].name : var.existing_resource_group_name
  resource_group_location     = var.existing_resource_group_name == null ? azurerm_resource_group.new[0].location : var.location
}
