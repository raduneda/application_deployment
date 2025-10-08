locals {
  location         = "westeurope"
  location_short   = "we"
  environment      = "dev"
  subscription_id  = "935384ec-dbe0-46b5-aaeb-d8e0532f7c67"
  application      = "sample1"
  common_name      = "${local.application}-${local.environment}-${local.location_short}"
  owner            = "raduneda@gmail.com"
  enable_telemetry = false
  deploy_env       = false

  asp_free = {
    name                   = "asp-${local.common_name}-free"
    sku_name               = "F1"
    os_type                = "Linux"
    zone_balancing_enabled = false
    worker_count           = 1
  }

  app_svc_free = {
    kind                    = "webapp"
    name                    = "wap-${local.common_name}-free"
    os_type                 = local.asp_free.os_type
    client_certificate_mode = "Optional"
    app_settings = {
      "DOCKER_CUSTOM_IMAGE_NAME" = "mcr.microsoft.com/dotnet/samples:aspnetapp"
      "WEBSITES_PORT"            = "8080"
      "DOCKER_ENABLE_CI"         = "true"
    }
    enable_application_insights = false
    site_config = {
      always_on         = false
      use_32_bit_worker = true
    }
    public_network_access_enabled = true
  }

  resource_group = {
    name = "rg-${local.common_name}-svc"
  }
}
