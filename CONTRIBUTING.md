# Contributing

- [Contributing](#contributing)
  - [Setup IDE](#setup-ide)
  - [Build module](#build-module)
  - [Coding style](#coding-style)
  - [Versioning](#versioning)
    - [How to bump the module version](#how-to-bump-the-module-version)

## Setup IDE

It is highly recommended to use Visual Studio Code (VS Code) to contribute to this repository.

When you open the project folder, VS Code will recommend that you install certain extensions to help you with your development work.

Please note that some documentation sections will be specific to VS Code.
So, if you use another IDE, you will probably need to adapt the instructions.

## Build module

To build the module, follow these steps:

1. Git clone or direct download the source code.
2. Open the project directory inside VS Code.
3. Open a PowerShell integrated terminal.
4. Run the following commands:

    ```powershell
    # Unblock the script files
    Get-ChildItem -Filter *.ps1 -Recurse | Unblock-File

    # Install and import InvokeBuild module
    Install-Module -Name InvokeBuild -Scope CurrentUser
    Import-Module -Name InvokeBuild

    # Run the default task to install dependencies
    Invoke-Build -Bootstrap
    ```

## Coding style

This repository follows [the PowerShell programming best practices and style rules](https://poshcode.gitbook.io/).

Please, ensure that you respect these rules when you develop new features for this module.

## Versioning

This project adheres to a basic version of [Semantic Versioning](https://semver.org/).

Version must respect the format `<major>.<minor>.<patch>`.

It is implemented by the `System.Version` PowerShell object.

### How to bump the module version

In the [`settings.ps1`](./settings.ps1) file, edit `$ModuleVersion`.
