# Terraform Beginner Bootcamp 2023!

## Semantic Versioning

The project will be using semantic versioning to tag changes. Source: [semver.org](https://semver.org).

It typically follows this format:

**MAJOR.MINOR.PATCH**, for instance: `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes

Due to changes in Terraform CLI installation instructions as a result of gpg keyring changes, the latest documentation was consulted to obtain the latest scripting for install:

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Refactoring into Bash Scripts

The Terrafom CLI gpg deprecation issue resulted in more code with bash script. Hence a bash script was created to install the Terraform CLI. 

The bash script can be found at [./bin/install_terraform_cli](./bin/install_terraform_cli). 

This helps to 
- keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy
- more easily debug and manually execute Terraform CLI install
- allow better portability for subsequent projects that will require Terraform CLI install

###How to check your Linux type

An example of how to check OS 
```sh
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```
https://beebom.com/how-check-linux-version/ \


#### Shebang

This informs the bash script what program will interpret the script. e.g. `#!/bin/bash`

This was the recommendation by ChatGPT for bash:
`#!/usr/bin/env bash`

This ensures 
- portability of different OS distros
- searching user's PATH for teh bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)
### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute it.

e.g. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml, we need to point the script to a program to interpret it.

e.g. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

To make our bash script executable at teh user mode, there is a need to change Linux permission thus:

```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### GitHub Lifecycle (Before, Init, Command)

Care should be taken with `Init` as it will not rerun if an existing workspace is restarted.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with Env Vars

#### env command

All Environment Variables (Env Vars) can be listed out using the `env` command

Specific env vars can be filtered using 'grep' e.g. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal, setting can be done using `export HELLO='world'` 

while unsetting can be done using `unset HELLO`

Env var can also be temporarily set when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script env var can be set without writing export e.g.

```sh
#!/usr/bin/env bash
HELLO='world'

echo $HELLO
```

#### Printing Vars

Env var can be printed usong 'echo' e.g. `echo $HELLO`

#### Scoping of Env Vars

When a new bash terminal is opened in VS Code, it will not be aware of env vars set in another window.

To have Env Vars persist across all future bash terminals that are open, env vars need to be set in the bash profile e.g. `.bash_profile`

#### Persisting Env Vars in Gitpod

Env vars can be persisted into Gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminasls opened in those workspaces.

Env vars can also be set in `.gitpod.yml` but this can only be non-sensitive.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

The following AWS CLI command can be run to check if AWS credentials are configured correctly:

```sh
aws sts get-caller-identity
```

If successful, a json payload return that looks like this should be seen:

```json
{
    "UserId": "ZIDAX2RTJMD9DKEQCM3VP",
    "Account": "109876543211",
    "Arn": "arn:aws:iam::109876543211:user/terraform_beginner_exampro"
}
```

There is a need to generate AWS CLI credentials from IAM user in order to use the AWS CLI.


## Terraform Basics

### Terraform Registry

The Terraform Registry is a centralized platform provided by HashiCorp for sharing and discovering reusable infrastructure code modules. It serves as a repository for Terraform modules, which are pre-built, configurable pieces of infrastructure code that can be easily integrated into one's own infrastructure-as-code (IaC) projects. Terraform users can search the registry to find modules that suit their needs, making it a valuable resource for simplifying and accelerating infrastructure provisioning and management tasks.
[registry.terraform.io](https://registry.terraform.io/)

- **Providers** are plugins that define and manage resources from specific cloud or infrastructure platforms, such as AWS, Azure, or Google Cloud. They act as intermediaries between Terraform configurations and the underlying APIs of these platforms, enabling Terraform to create, update, or delete resources on those platforms.

- **Modules** are reusable and encapsulated units of configuration that allow you to package and organize infrastructure code. They enable you to define, parameterize, and reuse sets of resources, making it easier to maintain and scale your infrastructure-as-code projects.

### Terraform Console
The Terraform console is a command-line tool that provides an interactive environment for evaluating and testing expressions within the context of a Terraform configuration, making it a useful tool for debugging and exploring Terraform configurations. It allows users to interactively inspect variables, functions, and resource attributes to ensure they are correctly defined and behaving as expected.

#### Terraform Init
`terraform init` initializes a Terraform project by downloading required plugins and modules, ensuring that it's ready for configuration deployment. This command is a crucial first step when setting up or updating Terraform configurations.

#### Terraform Plan
`terraform plan` analyzes a Terraform configuration and generates an execution plan, showing the changes it will make to your infrastructure without actually applying those changes.

#### Terraform Apply
`terraform apply` executes the changes outlined in the execution plan generated by `terraform plan`, effectively provisioning or modifying infrastructure resources to match the desired state defined in your Terraform configuration.

The `terraform --auto-approve` command allows for automatic execution of Terraform changes without requiring manual confirmation, streamlining deployment in automated workflows.

### Terraform Destroy
`terraform destroy` is a Terraform command that initiates the process of tearing down or destroying the infrastructure resources defined in the Terraform configuration. It reverses the changes made by a previous `terraform apply` operation, effectively decommissioning and deleting the resources to bring  infrastructure back to its initial state or as specified in the configuration. This command should be used with caution, as it can lead to the permanent removal of infrastructure resources.

### Terraform Lock Files

Terraform lock files, like `terraform.lock.hcl`, prevent concurrent modification of Terraform configurations, ensuring integrity during operations like `terraform apply` or `terraform plan`.

### Terraform State Files

Terraform state files, usually `terraform.tfstate`, store the current state of managed infrastructure, mapping it to the configuration and guiding actions in `terraform apply`. They should be securely managed and **should not be committed** to version control system.

`terraform.tfstate.backup` is an automatic backup of the primary Terraform state file (`terraform.tfstate`) used to safeguard against data loss or corruption.

### Terraform Directory
A Terraform directory is a folder or directory in the file system for organizing and storing Terraform configuration files, including `.tf` files, modules, and any other necessary files like variable definitions or provider configurations. It serves as the workspace where infrastructure-as-code projects using Terraform are defined and managed.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash in a WYSIWG view to generate a token; howwver, it does not work as expected in Gitpod VS Code in the browser.

The workaround is to manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens
```

Then create the file manually like so:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```

And then open the file thus:

```sh
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

And then paste this code in the file, filling in your token in place of *"YOUR-TERRAFORM-TOKEN-HERE"*

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN-HERE"
    }
  }
}
```

This workaround was automated with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)