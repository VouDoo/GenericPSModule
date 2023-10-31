# Contributing

- [Contributing](#contributing)
  - [Setup IDE](#setup-ide)
  - [Build module](#build-module)
  - [Coding style](#coding-style)
  - [Versioning](#versioning)
    - [How to bump the module version](#how-to-bump-the-module-version)

## Setup IDE

It is highly recommended to use Visual Studio Code to contribute to this repository.

Else, you won't be able to use some interesting features like Tasks, auto-formating, etc.

## Build module

Run these commands to build the module:

```powershell
# Install and import InvokeBuild module
Install-Module -Name InvokeBuild -Scope CurrentUser
Import-Module -Name InvokeBuild

# Run the default task to install dependencies
Invoke-Build -Bootstrap
```

## Coding style

This repository follows the best practices from [powershell-practice-and-style](https://poshcode.gitbook.io/).

## Versioning

This project adheres to version basic version of [Semantic Versioning](https://semver.org/).

Version must respect the format `<major>.<minor>.<patch>`.

It is implemented by the `System.Version` PowerShell object.

### How to bump the module version

In the [`settings.ps1`](./settings.ps1) file, edit `$ModuleVersion`.
