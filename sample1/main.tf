module "base_tags" {
  source            = "../modules/tags"
  environment       = local.environment
  application       = local.application
  owner             = local.owner
  technical_contact = local.owner
}

module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name             = local.resource_group.name
  location         = local.location
  enable_telemetry = local.enable_telemetry
  tags             = module.base_tags.tags
}


module "app_service_plan_free" {
  count                  = local.deploy_env ? 1 : 0
  source                 = "Azure/avm-res-web-serverfarm/azurerm"
  version                = "0.7.0"
  location               = local.location
  resource_group_name    = module.resource_group.name
  os_type                = local.asp_free.os_type
  name                   = local.asp_free.name
  zone_balancing_enabled = local.asp_free.zone_balancing_enabled
  sku_name               = local.asp_free.sku_name
  enable_telemetry       = local.enable_telemetry
  worker_count           = local.asp_free.worker_count
  tags                   = module.base_tags.tags
}


module "app_svc_free" {
  count                       = local.deploy_env ? 1 : 0
  source                      = "Azure/avm-res-web-site/azurerm"
  version                     = "0.19.1"
  name                        = local.app_svc_free.name
  kind                        = local.app_svc_free.kind
  os_type                     = local.app_svc_free.os_type
  resource_group_name         = module.resource_group.name
  location                    = local.location
  service_plan_resource_id    = module.app_service_plan_free[0].resource_id
  enable_telemetry            = local.enable_telemetry
  client_certificate_mode     = local.app_svc_free.client_certificate_mode
  app_settings                = local.app_svc_free.app_settings
  enable_application_insights = local.app_svc_free.enable_application_insights
  site_config                 = local.app_svc_free.site_config
}
