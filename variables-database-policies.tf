

variable "database_roles" {
  type        = map(map(list(string)))
  description = "A map of database engine paths, whose values are a map of databases, each with a list of roles. Policies will be created for all of the roles provided"
  default     = null
}

