terraform {

#   cloud {
#     organization = "EuKnighT_Inc"

#     workspaces {
#       name = "my-terra-house"
#     }
#   }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}