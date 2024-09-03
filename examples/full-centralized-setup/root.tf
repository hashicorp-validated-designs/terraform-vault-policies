#
# You must replace the source (and version) to match your enviornment
#
module "root_policies" {
  source    = "localterraform.com/MYORG/policies/vault"
  version   = "1.0.0"
  providers = { vault = vault.root }

  create_root_namespace_policies = true
}

