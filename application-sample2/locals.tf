locals {
  location         = "westeurope"
  location_short   = "we"
  environment      = "dev"
  subscription_id  = "40ad5184-5700-4ea0-9ee0-e0ce6e162d48"
  application      = "sample2"
  common_name      = "${local.application}-${local.environment}-${local.location_short}"
  owner            = "raduneda@gmail.com"
  enable_telemetry = false
  deploy_env       = false

  asp = {
    name                   = "asp-${local.common_name}-pe"
    sku_name               = "B1"
    os_type                = "Linux"
    zone_balancing_enabled = false
    worker_count           = 1
  }

  app_svc = {
    kind                    = "webapp"
    name                    = "wap-${local.common_name}-pe"
    os_type                 = local.asp.os_type
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
  }

  resource_group = {
    name = "rg-${local.common_name}-svc"
  }
}
