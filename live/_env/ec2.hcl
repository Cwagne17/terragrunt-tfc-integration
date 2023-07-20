locals {
  source_base_url = "tfr:///terraform-aws-modules/ec2-instance/aws"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets = ["subnet-12345678"]
  }
}
