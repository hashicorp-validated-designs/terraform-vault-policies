
# Allow access to internal endpoints used by the UI
path "sys/internal/ui/*" {
	capabilities = ["read", "list"]
}

path "sys/internal/counters/*" {
	capabilities = ["read"]
}

path "+/sys/internal/ui/*" {
	capabilities = ["read", "list"]
}

path "+/sys/internal/counters/*" {
	capabilities = ["read"]
}

# Allow access to license status
path "sys/license/status" {
	capabilities = ["read"]
}

path "+/sys/license/status" {
	capabilities = ["read"]
}

# Allow the token to determine it's own capabilities
path "sys/capabilities-self" {
        capabilities = ["update"]
}

path "+/sys/capabilities-self" {
        capabilities = ["update"]
}

