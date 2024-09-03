
variable "create_admin_namespace_policies" {
  type        = bool
  default     = false
  description = "If set to true, then it will create policies meant for the admin namespace (where people login) on the namespace of the provider. This is useful in the admin namespace for Vault. It defaults to false."
}

