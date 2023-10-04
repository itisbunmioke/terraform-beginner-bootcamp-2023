# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

The root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf - everything else
│
├── variables.tf - stores the structure of input variables
│
├── providers.tf - defined required providers and their configuration
│
├── outputs.tf - stores the inputs
│
├── terraform.tfvars - the data of variables we want to load into the terraform project
│
└── README.md - required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
