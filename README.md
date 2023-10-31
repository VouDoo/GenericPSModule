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
