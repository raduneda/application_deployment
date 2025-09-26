output "free_tier_app_svc_hostname" {
  value = module.app_svc_free.*.resource_uri
}
