
variable "create_root_namespace_policies" {
  type        = bool
  default     = false
  description = "If set to true, then it will create policies meant for the root namespace on the namespace of the provider. This is only useful in the root namespace for Vault, so it defaults to false."
}

