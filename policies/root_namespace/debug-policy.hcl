# Policy for vault debug
# https://developer.hashicorp.com/vault/docs/commands/debug
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

path "sys/pprof/*" {
  capabilities = ["read"]
}

path "sys/config/state/sanitized" {
  capabilities = ["read"]
}

path "sys/monitor" {
  capabilities = ["read"]
}

path "sys/host-info" {
  capabilities = ["read"]
}

path "sys/in-flight-req" {
  capabilities = ["read"]
}

