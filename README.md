
# terraform-vault-policies

This module provides a set of standard policies to get started with Vault:

* It can create a useful set of policies for the root namespace.
* It can create a useful set of policies for the admin namespace.
* This module can also be used to configure standard Vault policies for secret access. It will create these policies in an organization's admin namespace (where people login) and it's children namespaces (where secret engines are mounted, and applications login).

## Prerequisites

This module requires that the Vault namespace structure is already in place. For an example that creates the child namespace and configures the policies please see the examples directory.

This module only creates the policies, any secret engine that needs to be used needs to be installed and configured separately, and it's mount path, secret names, and role names need to match as applicable to the secret engine.

# Managed Vault policies

## Root namespace

This module provides some useful polcies for the root namespace. This is only applicable for Vault Enterprise. Only Vault admins need to login to this namespace. The following policies are currently managed:

* super-admin
* admin
* debug-policy
* dr-operation-token
* dr-replication-admin
* metrics-consumer
* namespace-producer
* policy-admin

## Admin namespace

This module provides some useful polcies for the admin namespace. This is the namespace where people consuming Vault will login to. Currently the following policies can be managed by this module:

* super-admin
* admin
* namespace-admin
* namespace-consumer
* namespace-producer
* policy-admin
* policy-consumer
* policy-producer
* ui

## Supported secret engines

At this time, this module supports creating standard policies for only a select number of secret engines, more will be added in the future. The following engines are currently suppored by this module:

* KV version 1 secret engine
* KV version 2 secret engine
* database secret engines, for both static and dynamic roles
 
This module will create access policies meant for people in the admin namespace. It will also create access policies meant for applications within the child namespace where the engines are expected to be mounted.


## Module support

This open source software is maintained by the HashiCorp Technical Field Organization, independently of our enterprise products. While our Support Engineering team provides dedicated support for our enterprise offerings, this open source software is not included.

- For help using this open source software, please engage your account team.
- To report bugs/issues with this open source software, please open them directly against this code repository using the GitHub issues feature.

Please note that there is no official Service Level Agreement (SLA) for support of this software as a HashiCorp customer. This software falls under the definition of Community Software/Versions in your Agreement. We appreciate your understanding and collaboration in improving our open source projects.

