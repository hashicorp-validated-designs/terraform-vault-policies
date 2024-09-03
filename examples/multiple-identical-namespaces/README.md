
# Description

This example is meant to be run at the admin namespace, it will:

* Use child namespaces called "example1" and "example2". These names are configurable through a variable in the sample code.
* Create an identical set of standard policies for access to secret engines in all the child namespaces. Some policies will be created in the admin namespace (meant to be attached to grant access to people) and some will be created inside the example1 namespace (meant to grant access to applications).

This sample is useful if you have a standard set of secret engines mounted in consistent locations for all namespaces.

# Prerequisites

* This example requires dynamic credentials for the admin namespace configured in HCP Terraform. The default configuration needs to be the one for the admin namespace.
* The admin namespace needs to already exist in Vault.
* The child namespaces needs to already exist in Vault.
* The credentials configured for HCP Terraform need to have access to create policies.

