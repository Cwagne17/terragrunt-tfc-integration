# terragrunt-tfc-integration

This repository is a proof of concept of what implementing terraform modules would like using terragrunt and TFC.

The reason that terragrunt is very useful is because it provides DRY configruation.
The reason that TFC is useful is because it allows for a UI to manage terraform state, view runs, and drift detection.

However, terragrunt does not integrate directly with TFC. This repository is a proof of concept of how to integrate the two following the terragrunt documentation.

## Setup

1. Create a TFC organization
2. Create a TFC project
3. [Setup Dynamic Credentials with AWS Provider](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration#dynamic-credentials-with-the-aws-provider)
   1. Configure AWS OIDC identity provider and role
   2. Configure TFC environment variables
4. Add TFC token to CircleCI `TFC` context
