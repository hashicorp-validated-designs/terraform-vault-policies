
run "create-root-ns-policies" {
  command = plan

  variables {
    create_root_namespace_policies = true
  }


  assert {
    condition     = length(keys(vault_policy.root_ns_policies)) > 1
    error_message = "Policies for the root namespace should be created"
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
    condition     = length(keys(vault_policy.database-engine-user-policy)) == 0
    error_message = "Policy for database engine shouldn't be created"
  }
}

run "dont-create-root-ns-policies" {
  command = plan

  variables {
    create_root_namespace_policies = false
  }


  assert {
    condition     = length(keys(vault_policy.root_ns_policies)) == 0
    error_message = "Policies for the root namespace shouldn't be created"
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
    condition     = length(keys(vault_policy.database-engine-user-policy)) == 0
    error_message = "Policy for database engine shouldn't be created"
  }
}

