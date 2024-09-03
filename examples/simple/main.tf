# This example will use an existing namespace and it will
# define policies for a database engine, a KV v1 and a KV v2 engine in
# the authenticating namespace as well as in the pre-existing child namespace called example1
#
# You must replace the source (and version) to match your enviornment
#

variable "child_namespace" {
  type        = string
  description = "Child namespace for the target policies. Defaults to example1"
  default     = "example1"
}

data "vault_namespace" "secret_ns" {
  path = var.child_namespace
}

module "example1_policies" {
  source  = "localterraform.com/MYORG/policies/vault"
  version = "1.0.0"

  namespace_name = data.vault_namespace.secret_ns.path

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

