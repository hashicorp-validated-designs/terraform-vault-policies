
# Read the engine policy files from the directory
data "local_file" "database_engine_policy_files" {
  for_each = fileset("${path.module}/policies/database-engine", "*.hcl.tftpl")

  # Get the file path of each policy file
  filename = "${path.module}/policies/database-engine/${each.key}"
}

data "local_file" "database_role_policy_files" {
  for_each = fileset("${path.module}/policies/database-role", "*.hcl.tftpl")

  # Get the file path of each policy file
  filename = "${path.module}/policies/database-role/${each.key}"
}

locals {
  database_engines         = { for a in flatten(try([for k, v in var.database_roles : [for d, r in v : { engine = k, db = d }]], [])) : "${a.engine}-${a.db}" => a }
  database_roles           = { for a in flatten(try([for k, v in var.database_roles : [for d, r in v : [for l in r : { engine = k, role = l, db = d }]]], [])) : "${a.engine}-${a.db}-${a.role}" => a }
  database_engine_policies = { for a in setproduct(keys(data.local_file.database_engine_policy_files), keys(local.database_engines)) : "${element(a, 1)}-${element(a, 0)}" => merge({ basename = replace(element(a, 0), ".hcl.tftpl", "") }, local.database_engines[element(a, 1)]) }
  database_role_policies   = { for a in setproduct(keys(data.local_file.database_role_policy_files), keys(local.database_roles)) : "${element(a, 1)}-${element(a, 0)}" => merge({ basename = replace(element(a, 0), ".hcl.tftpl", "") }, local.database_roles[element(a, 1)]) }
}

resource "vault_policy" "database-engine-user-policy" {
  for_each = local.database_engine_policies

  name = "${data.vault_namespace.this.path_fq}/${each.value.engine}-${each.value.db}-${each.value.basename}"
  policy = templatefile("${path.module}/policies/database-engine/${each.value.basename}.hcl.tftpl", {
    namespace      = "${data.vault_namespace.this.path_fq}/"
    db_engine_path = each.value.engine
    connection     = each.value.db
  })
}

resource "vault_policy" "database-engine-child-ns-policy" {
  for_each  = local.database_engine_policies
  namespace = data.vault_namespace.this.path_fq

  name = "${each.value.engine}-${each.value.db}-${each.value.basename}"
  policy = templatefile("${path.module}/policies/database-engine/${each.value.basename}.hcl.tftpl", {
    namespace      = ""
    db_engine_path = each.value.engine
    connection     = each.value.db
  })
}

resource "vault_policy" "database-role-user-policy" {
  for_each = local.database_role_policies

  name = "${data.vault_namespace.this.path_fq}/${each.value.engine}-${each.value.db}-${each.value.role}-${each.value.basename}"
  policy = templatefile("${path.module}/policies/database-role/${each.value.basename}.hcl.tftpl", {
    namespace      = "${data.vault_namespace.this.path_fq}/"
    db_engine_path = each.value.engine
    role           = each.value.role
  })
}

resource "vault_policy" "database-role-app-policy" {
  for_each  = local.database_role_policies
  namespace = data.vault_namespace.this.path_fq

  name = "${each.value.engine}-${each.value.db}-${each.value.role}-${each.value.basename}"
  policy = templatefile("${path.module}/policies/database-role/${each.value.basename}.hcl.tftpl", {
    namespace      = ""
    db_engine_path = each.value.engine
    role           = each.value.role
  })
}

