# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag
```sh
$ git tag -d <tag_name>
```

Remotely delete a tag

```sh
$ git push --delete origin tagname
```
Checkout the commit that you want to retag. Grab the SHA from your GitHub history

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

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

In Terraform, variable values are assigned in the following order of precedence:

1. Environment Variables
1. Command-Line Flags
1. Variable Files
1. Default Values in Variable Declarations
1. Interactive Input
1. Data Source Values
1. Remote Backend (Terraform Cloud)

Values from higher-precedence sources override lower-precedence ones.

## Dealing with Configuration Drift

## What happens if we lose our state file?

If state file is lost, all the cloud infrastructure needs to be torn down manually

terraform import can be used but it won't work for all cloud resource. The Terraform providers' documentation needs to be checked for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps.

If we run Terraform plan in an attempt to put our infrastructure back into the expected state fixing Configuration Drift

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```
## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when localled developing modules but you can name it whatener you like.

### Passing Input Variables

We can pass input variables to our module.

The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Module Sources

Using the source we can import the module from various places e.g.
- Locally
- GitHub
- Terraform Registry

```tf
module "terrahouse" {
  source = "./modules/terrahouse_aws"
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the lates documentation or information about Terraform.  It may likely produce older examples that could be be deprecated, often affecting providers.

## Working with FIles in Terraform

### Fileexists Function

This is a built-in terraform function to check the existence of a file.

```tf
 condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In Terraform. there is a special variable called `path` that allows us to referece local paths:
- path.module = get the path for the curent module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references)

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  etag = filemd5(var.index_html_filepath)
}

## Terraform Locals

Locals allow us to define local variables.
It can be very useful when we need to transform data into another format and have it referenced as a variable.

```tf
locals {
    s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the jsonencode to create the JSON policy in line in the HCL. 

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
[jsencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources

[Meta-Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Provisioners

Provisioners allow you to execute commands on compute instances e.g. an AWS CLI command.

They are not recommended for use by Hashicorp because Configuratioon Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute a command on the machine running the terraform commands e.g. plan, apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}

```
# https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec


### Remote-exec
This will execute commands on a machine which you target. You will need to provide credentiasl such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```
# https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec

