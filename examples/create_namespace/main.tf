# This example will create a new namespace and it will
# define policies for a database engine, a KV v1 and a KV v2 engine in
# the authenticating namespace as well as in the created child namespace called example1
#
# You must replace the source (and version) to match your enviornment
#

resource "vault_namespace" "secret_ns" {
  path = "example1"
}

module "example1_policies" {
  source  = "localterraform.com/MYORG/policies/vault"
  version = "1.0.0"

  namespace_name = vault_namespace.secret_ns.path

  database_roles = {
    "postgres/app1" = { core_db = ["oltp", "reports"] }
  }

  kv_v1_secrets = {
    "secrets/kvv1" = ["experiment1", "experiment2"]
  }

  kv_v2_secrets = {
    "secrets/kvv2" = ["experiment626"]
  }

  depends_on = [vault_namespace.secret_ns]
}

