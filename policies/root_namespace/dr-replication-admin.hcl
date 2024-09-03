# To enable DR primary
path "sys/replication/dr/primary/enable" {
  capabilities = ["create", "update"]
}

# To generate a secondary token required to add a DR secondary
path "sys/replication/dr/primary/secondary-token" {
  capabilities = ["create", "update", "sudo"]
}

# To create ACL policies
path "sys/policies/acl/*" {
  capabilities = ["create", "update", "list"]
}

# Create a token role for batch DR operation token
path "auth/token/roles/*" {
  capabilities = ["create", "update"]
}

# Create a token
path "auth/token/create" {
  capabilities = ["create", "update"]
}

# To demote the primary to secondary
path "sys/replication/dr/primary/demote" {
  capabilities = ["create", "update"]
}

# To enable DR secondary
path "sys/replication/dr/secondary/enable" {
  capabilities = ["create", "update"]
}

# To generate an operation token
path "sys/replication/dr/secondary/generate-operation-token/*" {
  capabilities = ["create", "update"]
}

# To promote the secondary cluster to be primary
path "sys/replication/dr/secondary/promote" {
  capabilities = ["create", "update"]
}

# To update the assigned primary cluster
path "sys/replication/dr/secondary/update-primary" {
  capabilities = ["create", "update"]
}

# If you choose to disable the original primary cluster post-recovery
path "sys/replication/dr/primary/disable" {
  capabilities = ["create", "update"]
}

