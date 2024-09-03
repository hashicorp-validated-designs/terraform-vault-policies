# This example will use an existing namespace and it will
# define policies for a database engine, a KV v1 and a KV v2 engine in
# the authenticating namespace as well as in the pre-existing child namespaces
#
# You must replace the source (and version) to match your enviornment
#


module "example1_policies" {
  source  = "localterraform.com/MYORG/policies/vault"
  version = "1.0.0"

  namespace_name = "example1"

  database_roles = {
    "postgres/app1" = { core_db = ["oltp", "reports"] }
  }

  kv_v1_secrets = {
    "secrets/kvv1" = ["experiment1", "experiment2"]
  }

  kv_v2_secrets = {
    "secrets/kvv2" = ["experiment626"]
  }
}

module "example2_policies" {
  source  = "localterraform.com/MYORG/policies/vault"
  version = "1.0.0"

  namespace_name = "example2"

  database_roles = {
    "postgres/app101" = {
      "appdb" = ["dbuser"]
    }
  }

  kv_v1_secrets = {
    "secrets/kvv1" = ["mysecrets"]
  }

  kv_v2_secrets = {
    "secrets/kvv2" = ["private"]
  }
}

