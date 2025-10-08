module "app_svc" {
  source                      = "Azure/avm-res-web-site/azurerm"
  version                     = "0.19.1"
  name                        = var.app_svc.name
  kind                        = var.app_svc.kind
  os_type                     = var.app_svc.os_type
  resource_group_name         = var.resource_group_name
  location                    = var.location
  service_plan_resource_id    = var.app_service_plan_resource_id
  enable_telemetry            = var.enable_telemetry
  client_certificate_mode     = var.app_svc.client_certificate_mode
  app_settings                = var.app_svc.app_settings
  enable_application_insights = var.app_svc.enable_application_insights
  site_config                 = var.app_svc.site_config
  public_network_access_enabled = var.app_svc.public_network_access_enabled
  tags                        = var.tags
  private_endpoints = { for k, v in var.private_endpoints :
    k => {
      subnet_resource_id            = data.azurerm_subnet.pe_subnet.id
      private_dns_zone_resource_ids = local.private_dns_zone_resource_ids
    }
  }
}
