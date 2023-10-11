terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "ExamPro"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
 source = "./modules/terrahouse_aws"
 user_uuid = var.teacherseat_user_uuid
 bucket_name = var.bucket_name
 index_html_filepath = var.index_html_filepath
 error_html_filepath = var.error_html_filepath
 content_version = var.content_version
 assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Play Age of Empires II in 2023!"
  description = <<DESCRIPTION
Age of Empires II: The Age of Kings

Age of Empires II: The Age of Kings is a classic real-time strategy (RTS) game that takes players on an epic journey through various historical periods. Developed by Ensemble Studios and first released in 1999, this game has stood the test of time and remains a beloved title among strategy gaming enthusiasts.

In Age of Empires II, players are tasked with building and managing their civilization from the ground up. You'll start in the Dark Ages with a small village and gradually advance through the Feudal Age, Castle Age, and Imperial Age. Along the way, you'll gather resources, train armies, and engage in intense battles with other civilizations, all while exploring richly detailed and historically inspired environments.

One of the game's standout features is its diverse array of civilizations to choose from, each with its own unique units, technologies, and bonuses. Whether you're leading the powerful Byzantines, the fierce Mongols, or the resourceful Vikings, every civilization offers a distinct gameplay experience.

Age of Empires II also includes a captivating single-player campaign that spans different historical periods and introduces players to iconic figures and events. Additionally, multiplayer mode allows you to challenge friends or other players online, testing your strategic skills in intense matches.

With its combination of deep strategy, historical authenticity, and engaging gameplay, Age of Empires II: The Age of Kings has earned its place as a timeless classic in the world of real-time strategy gaming.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  # domain_name = "3fdq3gz.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}