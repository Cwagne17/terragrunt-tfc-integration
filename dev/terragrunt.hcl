locals {
  tfc_hostname     = "app.terraform.io"
  tfc_organization = "Personal-GH"

  module      = path_relative_to_include()                          # this will find the name of the module aka. "vpc"
  environment = reverse(split("/", get_parent_terragrunt_dir()))[0] # this will find the name of the folder aka. "dev"
  region      = "us-east-1"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
}
EOF
}

generate "remote_state" {
  path      = "backend_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.36.0"
    }
  }

  backend "remote" {
      hostname     = "${local.tfc_hostname}"
      organization = "${local.tfc_organization}"
      workspaces {
          name = "${local.module}-${local.environment}-${local.region}"
      }
  }
}
EOF
}
