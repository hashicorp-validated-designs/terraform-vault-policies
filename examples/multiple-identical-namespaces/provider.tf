
provider "vault" {
  skip_child_token = true
  address          = var.tfc_vault_dynamic_credentials.default.address
  namespace        = var.tfc_vault_dynamic_credentials.default.namespace
  #ca_cert_file     = "${path.cwd}/${var.tfc_vault_dynamic_credentials.default.ca_cert_file}"
  #ca_cert_file     = "${path.root}/VAULT-RootCA.crt"
  auth_login_token_file {
    filename = var.tfc_vault_dynamic_credentials.default.token_filename
  }
}

variable "tfc_vault_dynamic_credentials" {
  description = "Object containing Vault dynamic credentials configuration"
  type = object({
    default = object({
      token_filename = string
      address        = string
      namespace      = string
      ca_cert_file   = string
    })
    aliases = map(object({
      token_filename = string
      address        = string
      namespace      = string
      ca_cert_file   = string
    }))
  })
}

