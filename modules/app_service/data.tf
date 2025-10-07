data "azurerm_subnet" "pe_subnet" {
  name                 = "sn-${var.common_name}-private_endpoints"
  virtual_network_name = "vnet-${var.common_name}-spoke"
  resource_group_name  = "rg-${var.common_name}-network"
}