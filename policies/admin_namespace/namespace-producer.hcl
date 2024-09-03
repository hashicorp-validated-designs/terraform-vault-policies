
# Manage namespaces in the admin namespace
path "sys/namespaces/*" {
   capabilities = ["create", "read", "update", "list"]
}

