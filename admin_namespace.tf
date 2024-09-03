
# Read the policy files from the directory
data "local_file" "admin_ns_policy_files" {
  for_each = fileset("${path.module}/policies/admin_namespace", "*.hcl")

  # Get the file path of each policy file
  filename = "${path.module}/policies/admin_namespace/${each.key}"
}

# Create Vault policies for admin namespace
resource "vault_policy" "admin_ns_policies" {
  for_each = tomap(var.create_admin_namespace_policies ? data.local_file.admin_ns_policy_files : {})

  name   = trimprefix(trimsuffix("${each.key}", ".hcl"), "${path.module}/policies/admin_namespace/")
  policy = each.value.content
}

