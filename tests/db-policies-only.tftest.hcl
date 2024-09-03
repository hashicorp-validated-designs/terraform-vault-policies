
run "db-policies" {
  command = plan

  variables {
    namespace_name = "test1"

    database_roles = {
      "postgres/app1" = { core_db = ["oltp", "reports"] }
    }
  }


  assert {
    condition     = length(keys(vault_policy.kvv1-user-policy)) == 0
    error_message = "Policies for kv-v1 users shouldn't be created"
  }
  assert {
    condition     = length(keys(vault_policy.kvv2-user-policy)) == 0
    error_message = "Policies for kv-v2 users shouldn't be created"
  }
  assert {
    condition     = length(keys(vault_policy.database-engine-user-policy)) == 1
    error_message = "Policy for database engine should be created"
  }
}

