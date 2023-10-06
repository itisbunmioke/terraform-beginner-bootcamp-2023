terraform {

#   cloud {
#     organization = "EuKnighT_Inc"

#     workspaces {
#       name = "my-terra-house"
#     }
#   }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}