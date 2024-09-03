# This example will configure policies useful in the admin namespace
#
# You must replace the source (and version) to match your enviornment
#

module "admin_policies" {
  source  = "localterraform.com/MYORG/policies/vault"
  version = "1.0.0"

  create_admin_namespace_policies = true
}

