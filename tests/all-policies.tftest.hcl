
run "all-secret-policies" {
  command = plan

  variables {
    namespace_name = "test1"

    database_roles = {
      "postgres/app1" = { core_db = ["oltp", "reports"] }
    }

    kv_v1_secrets = {
      "secrets/kvv1" = ["experiment1", "experiment2"]
    }

    kv_v2_secrets = {
      "secrets/kvv2" = ["experiment626"]
    }

  }


  assert {
    condition     = length(keys(vault_policy.kvv1-user-policy)) == 6
    error_message = "Policies for kv-v1 users should be created"
  }
  assert {
    condition     = length(keys(vault_policy.kvv2-user-policy)) == 3
    error_message = "Policies for kv-v2 users should be created"
  }
  assert {
    condition     = length(keys(vault_policy.database-engine-user-policy)) == 1
    error_message = "Policy for database engine should be created"
  }
}

