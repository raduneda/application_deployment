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

module "app_service_plan" {
  count               = local.deploy_env ? 1 : 0
  source              = "../modules/app_service_plan"
  location            = local.location
  resource_group_name = module.resource_group.name
  tags                = module.base_tags.tags
  asp_config          = local.asp
}

module "app_svc" {
  count                        = local.deploy_env ? 1 : 0
  source                       = "../modules/app_service"
  resource_group_name          = module.resource_group.name
  common_name                  = local.common_name
  app_service_plan_resource_id = module.app_service_plan[0].asp.resource_id
  location                     = local.location
  app_svc                      = local.app_svc
  private_endpoints = {
    "pe-${local.common_name}" = {}
  }
}
