
# Full control of namespaces in the admin namespace
path "sys/namespaces/*" {
   capabilities = ["create", "read", "update", "delete", "list"]
}

