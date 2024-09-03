
# Description

This example is meant to be run at the admin namespace, it will:

* Create a set of standard policies for access to secret engines in the example1 namespace. Some policies will be created in the admin namespace (meant to be attached to grant access to people) and some will be created inside the example1 namespace (meant to grant access to applications).

This example allows configuration of the name for the child namespace (defaulting to example1).

# Prerequisites

* This example requires dynamic credentials for the admin namespace configured in HCP Terraform. The default configuration needs to be the one for the admin namespace.
* The admin namespace needs to already exist in Vault.
* A namespace called "example1" (or the name given in the provided variable) needs to already exist in Vault.
* The credentials configured for HCP Terraform need to have access to create namespaces and policies.

