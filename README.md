# terragrunt-tfc-integration

This repository is a proof of concept of what implementing terraform modules would like using terragrunt and TFC.

The reason that terragrunt is very useful is because it provides DRY configruation.
The reason that TFC is useful is because it allows for a UI to manage terraform state, view runs, and drift detection.

However, terragrunt does not integrate directly with TFC. This repository is a proof of concept of how to integrate the two following the terragrunt documentation.

So far I have been unable to get this to work in continuous integration. I have been able to get it to work locally.

The issue that I have been experiencing and have been also finding others experiencing online is AWS provider credentials for the generated backend by terragrunt.

After confirming in CI that ~/.aws/credentials for the default profile is being created using a Web OIDC role for CircleCI, I am still getting the following error:

```bash
Error: error configuring Terraform AWS Provider: no valid credential sources for Terraform AWS Provider found.
│ 
│ Please see https://registry.terraform.io/providers/hashicorp/aws
│ for more information about providing credentials.
│ 
│ Error: failed to refresh cached credentials, no EC2 IMDS role found, operation error ec2imds: GetMetadata, request send failed, Get "http://169.254.169.254/latest/meta-data/iam/security-credentials/": dial tcp 169.254.169.254:80: i/o timeout
│ 
```

While terragrunt offers a lot of benefits, I have found it difficult to work with. The most notable difficulties I have experienced include:

1. Defining required providers in the backend.tf file using the generate block
2. Providing credentials to the AWS provider
