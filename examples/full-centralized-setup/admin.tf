# This example will create a new namespace and it will
# define policies for a database engine, a KV v1 and a KV v2 engine in
# the authenticating namespace as well as in the created child namespace called example1
#
# You must replace the source (and version) to match your enviornment
#

resource "vault_namespace" "admin_ns" {
  provider = vault.root

  path = "admin"
}

module "admin_policies" {
  source  = "carlosvilleg/policies/vault"
  version = "0.0.7"

  create_admin_namespace_policies = true

  depends_on = [vault_namespace.admin_ns]
}

