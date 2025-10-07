module "app_service_plan" {
  source                 = "Azure/avm-res-web-serverfarm/azurerm"
  version                = "0.7.0"
  location               = var.location
  resource_group_name    = var.resource_group_name
  os_type                = var.asp_config.os_type
  name                   = var.asp_config.name
  zone_balancing_enabled = var.asp_config.zone_balancing_enabled
  sku_name               = var.asp_config.sku_name
  enable_telemetry       = var.enable_telemetry
  worker_count           = var.asp_config.worker_count
  tags                   = var.tags
}