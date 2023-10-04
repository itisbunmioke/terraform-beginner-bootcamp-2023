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

# Terraform and Input Variables

## Terraform Cloud Variables

In terraform two kinds of variables can be set:
- Environment Variables - those you would set in the bash terminal e.g. AWS credentials
- Terraform Variables - those you would normally set in your tfvars file

Terraform Cloud variabels can be set to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input Variables

[Terraform Input Variable](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag

The `-var` flag can be used to set an input variable or override a variable in the tfvars file e.g. `terraform -var user_uuid="my_user_id`

### var-file flag

The `-var-file` flag allows storing variable values in a separate file (usually with a `.tfvars` extension) and use them when running Terraform commands. It's a way to keep variable values separate from main configuration, making it easier to manage different environments and sensitive data. 

The variable file is specified with `-var-file=my-variables.tfvars` when running Terraform commands like `terraform apply` or `terraform plan`.

### terraform.tfvars

This is the default file to load in terraform variables in bulk.

### auto.tfvars

The auto.tfvars file serves a similar purpose as the -var-file flag but with an automatic loading mechanism. 
When variable values are placed in an auto.tfvars file in the Terraform project directory, Terraform will automatically use those values when you commands like `terraform apply` or `terraform plan` are run, without needing to specify the variable file explicitly.

### Order of Terraform Variables

