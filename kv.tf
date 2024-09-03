
# Read the engine policy files from the directory
data "local_file" "kvv1_policy_files" {
  for_each = fileset("${path.module}/policies/kvv1", "*.hcl.tftpl")

  # Get the file path of each policy file
  filename = "${path.module}/policies/kvv1/${each.key}"
}

data "local_file" "kvv2_policy_files" {
  for_each = fileset("${path.module}/policies/kvv2", "*.hcl.tftpl")

  # Get the file path of each policy file
  filename = "${path.module}/policies/kvv2/${each.key}"
}

locals {
  kvv1_secrets         = { for a in flatten(try([for k, v in var.kv_v1_secrets : [for e, s in v : { engine = k, secret = s }]], [])) : "${a.engine}/${a.secret}" => a }
  kvv2_secrets         = { for a in flatten(try([for k, v in var.kv_v2_secrets : [for e, s in v : { engine = k, secret = s }]], [])) : "${a.engine}/${a.secret}" => a }
  kvv1_secret_policies = { for a in setproduct(keys(data.local_file.kvv1_policy_files), keys(local.kvv1_secrets)) : "${element(a, 1)}-${element(a, 0)}" => merge({ basename = replace(element(a, 0), ".hcl.tftpl", "") }, local.kvv1_secrets[element(a, 1)]) }
  kvv2_secret_policies = { for a in setproduct(keys(data.local_file.kvv2_policy_files), keys(local.kvv2_secrets)) : "${element(a, 1)}-${element(a, 0)}" => merge({ basename = replace(element(a, 0), ".hcl.tftpl", "") }, local.kvv2_secrets[element(a, 1)]) }
}


resource "vault_policy" "kvv1-user-policy" {
  for_each = local.kvv1_secret_policies

  name = "${data.vault_namespace.this.path_fq}/${each.value.engine}/${each.value.secret}-${each.value.basename}"
  policy = templatefile("${path.module}/policies/kvv1/${each.value.basename}.hcl.tftpl", {
    namespace        = "${data.vault_namespace.this.path_fq}/"
    kvv1_engine_path = each.value.engine
    kvv1_secret_path = each.value.secret
  })
}

resource "vault_policy" "kvv2-user-policy" {
  for_each = local.kvv2_secret_policies

  name = "${data.vault_namespace.this.path_fq}/${each.value.engine}/${each.value.secret}-${each.value.basename}"
  policy = templatefile("${path.module}/policies/kvv2/${each.value.basename}.hcl.tftpl", {
    namespace        = "${data.vault_namespace.this.path_fq}/"
    kvv2_engine_path = each.value.engine
    kvv2_secret_path = each.value.secret
  })
}

resource "vault_policy" "kvv1-app-policy" {
  for_each  = local.kvv1_secret_policies
  namespace = data.vault_namespace.this.path_fq

  name = "${each.value.engine}/${each.value.secret}-${each.value.basename}"
  policy = templatefile("${path.module}/policies/kvv1/${each.value.basename}.hcl.tftpl", {
    namespace        = ""
    kvv1_engine_path = each.value.engine
    kvv1_secret_path = each.value.secret
  })
}

resource "vault_policy" "kvv2-app-policy" {
  for_each  = local.kvv2_secret_policies
  namespace = data.vault_namespace.this.path_fq

  name = "${each.value.engine}/${each.value.secret}-${each.value.basename}"
  policy = templatefile("${path.module}/policies/kvv2/${each.value.basename}.hcl.tftpl", {
    namespace        = ""
    kvv2_engine_path = each.value.engine
    kvv2_secret_path = each.value.secret
  })
}

