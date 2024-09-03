
# Read the policy files from the directory
data "local_file" "root_ns_policy_files" {
  for_each = fileset("${path.module}/policies/root_namespace", "*.hcl")

  # Get the file path of each policy file
  filename = "${path.module}/policies/root_namespace/${each.key}"
}

# Create Vault policies for root namespace
resource "vault_policy" "root_ns_policies" {
  for_each = tomap(var.create_root_namespace_policies ? data.local_file.root_ns_policy_files : {})

  name   = trimprefix(trimsuffix("${each.key}", ".hcl"), "${path.module}/policies/root_namespace/")
  policy = each.value.content
}

