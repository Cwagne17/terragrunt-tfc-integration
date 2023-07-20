// Imports the root terragrunt.hcl file
// This provides the terraform and aws provider blocks
include "root" {
  path = find_in_parent_folders()
}

// Imports the environment specific configuration
// this only loads the data as a variable
// without merging the configurations
/* include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
} */

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"

  mock_outputs = {
    public_subnets = ["subnet-12345678"]
  }
}

// Imports the abstracted EC2 configuration
// This provides the EC2 module source as well as
// dependency configuration
include "ec2" {
  path   = "${get_terragrunt_dir()}/../../_env/ec2.hcl"
  expose = true
}

// Defines the terraform module to use
terraform {
  source = "${include.ec2.locals.source_base_url}?version=4.5.0"
}

// Inputs block cannot be used with terraform cloud
// for this reason the generate block is used to 
// generate the auto.tfvars file
//
// The auto.tfvars file is used to provide the inputs
// the file however is written to disc and should not be
// checked into source control 
/* generate "tfvars" {
  path              = "terragrunt.auto.tfvars"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = <<-EOF
name = "${include.ec2.locals.name}"
subnet_id = ${dependency.vpc.outputs.public_subnets[0]}
associate_public_ip_address = true
EOF
} */

generate = read_terragrunt_config("config.hcl")
