# This example will configure policies useful in the root namespace
#
# You must replace the source (and version) to match your enviornment
#

module "root_policies" {
  source  = "localterraform.com/MYORG/policies/vault"
  version = "1.0.0"

  create_root_namespace_policies = true
}

