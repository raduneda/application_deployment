variable "location" {
  description = "location value"
  type        = string
}

variable "resource_group_name" {
  description = "resoruce group name"
  type        = string
}

variable "asp_config" {
  description = "config for app service plan"
  type = object({
    name                   = string
    sku_name               = string
    os_type                = string
    zone_balancing_enabled = optional(bool, false)
    worker_count           = optional(number, 1)
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
