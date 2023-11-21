# GenericPSModule

Boilerplate project for PowerShell modules.

You can clone this repository if you intend to create new PowerShell module project.

**TODO** after cloning:

- Edit [`settings.ps1`](./settings.ps1):
  - Change value of the `$ModuleName` variable at line 1 with your module name.
  - Change value of the `$ModuleVersion` variable at line 2 with your module version.
- Edit [`source/manifest.psd1`](./source/manifest.psd1):
  - Change value of the `GUID` key.

    _Tips: you can generate a new GUID with the `New-GUID` Cmdlet._

  - Set/change value of any other required keys.
- Remove example functions and classes.

---

## Install from source

1. Unblock downloaded scripts

    ```powershell
    Get-ChildItem -Filter *.ps1 -Recurse | Unblock-File
    ```

2. Build the module (module `InvokeBuild` is required)

    ```powershell
    Invoke-Build -Task CompileModule -Bootstrap
    ```

3. You can import the release module in your current PS session

    ```powershell
    ./import.release.ps1
    ```

4. ... And/or install it too :)

    ```powershell
    ./install.release.ps1
    ```

---

## Contributing

Please, read the [CONTRIBUTING](./CONTRIBUTING.md) file to get more information.
