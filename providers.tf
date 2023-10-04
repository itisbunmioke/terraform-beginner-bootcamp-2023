terraform {

#   cloud {
#     organization = "EuKnighT_Inc"

#     workspaces {
#       name = "my-terra-house"
#     }
#   }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
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