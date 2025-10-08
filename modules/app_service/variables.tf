variable "location" {
  description = "location value"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "app_svc" {
  description = "config for app service plan"
  type = object({
    name                          = string
    kind                          = string
    os_type                       = string
    client_certificate_mode       = string
    app_settings                  = optional(map(string), {})
    enable_application_insights   = optional(bool, false)
    site_config                   = optional(any)
    public_network_access_enabled = optional(bool, false)
  })
}

variable "enable_telemetry" {
  description = "enable telemetry flag"
  type        = bool
  default     = false
}

variable "tags" {
  description = "tags for resources"
  type        = map(string)
  default     = {}
}

variable "common_name" {
  description = "Common resource name"
  type        = string
}

variable "app_service_plan_resource_id" {
  description = "App Service Plan resource id"
  type        = string
}

variable "private_endpoints" {
  description = "Map of private endpoints"
  type        = any
  default     = {}
}
