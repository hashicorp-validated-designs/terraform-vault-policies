# List existing policies in this namespace
path "sys/policies/acl"
{
  capabilities = ["list"]
}

# List existing policies in children namespaces
path "+/sys/policies/acl"
{
  capabilities = ["list"]
}

# Read ACL policies in this namespace
path "sys/policies/acl/*"
{
  capabilities = ["read"]
}

# Read ACL policies in children namespaces
path "+/sys/policies/acl/*"
{
  capabilities = ["read"]
}

