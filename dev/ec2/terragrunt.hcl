terraform {
  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=5.2.1"
}

include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc"]
}

inputs = {
  name                        = "my-ec2-instance"
  ami                         = "ami-06ca3ca175f37dd66"
  instance_type               = "t2.micro"
  subnet_id                   = dependency.vpc.outputs.public_subnets[0]
  associate_public_ip_address = true
}

/* generate "tfvars" {
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
} */
