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