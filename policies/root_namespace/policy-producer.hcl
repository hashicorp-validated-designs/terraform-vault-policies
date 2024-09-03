# Create and manage ACL policies in this namespace
path "sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "list"]
}

# Create and manage ACL policies in child namespaces
path "+/sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "list"]
}

