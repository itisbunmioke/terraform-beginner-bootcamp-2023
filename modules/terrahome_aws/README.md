## Terrahome AWS

```tf
module "home_ageofempires" {
 source = "./modules/terrahome_aws"
 user_uuid = var.teacherseat_user_uuid
 public_path = var.ageofempires_public_path
#  bucket_name = var.bucket_name
 content_version = var.content_version
}
```

The public directry expects the following:
- index.hml
- error.html
- assets

All top-level files in assets will be copied, but not any subdirectories.