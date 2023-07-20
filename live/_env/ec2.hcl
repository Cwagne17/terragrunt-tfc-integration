locals {
  environment = reverse(split("/", path_relative_to_include()))[0] # this will find the name of the folder aka. "dev"

  source_base_url = "tfr:///terraform-aws-modules/ec2-instance/aws"

  name          = "${local.environment}-tfc-integration"
  ami           = "ami-06ca3ca175f37dd66"
  instance_type = "t2.micro"
}
