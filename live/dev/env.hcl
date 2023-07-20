locals {
  env = reverse(split("/", get_parent_terragrunt_dir()))[0] # this will find the name of the folder aka. "dev"
}
