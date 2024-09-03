
variable "kv_v1_secrets" {
  type        = map(list(string))
  description = "A map where every key is the KV v1 engine path, and the value is a list of the secrets for which policies will be defined."
  default     = null
}

variable "kv_v2_secrets" {
  type        = map(list(string))
  description = "A map where every key is the KV v2 engine path, and the value is a list of the secrets for which policies will be defined."
  default     = null
}

