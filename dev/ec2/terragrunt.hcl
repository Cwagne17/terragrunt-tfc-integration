terraform {
  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=4.5.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc"]
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets = ["subnet-12345678"]
  }
}

generate "tfvars" {
  path              = "terragrunt.auto.tfvars"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = <<-EOF
ami = "ami-06ca3ca175f37dd66"
instance_type = "t2.micro"

name = "my-ec2-instance"

subnet_id = ""
associate_public_ip_address = true
EOF
}
