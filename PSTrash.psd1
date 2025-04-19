@{
    RootModule        = 'PSTrash.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = "bf7ea098-63cb-44f8-a7bc-e8bfb132dad3"
    Author            = "marcio1002"
    CompanyName       = "Marcio Alemão"
    PowerShellVersion = "5.1"
    Description       = "This module is a helper to manage files directly in the windows recycle bin"
    Copyright         = "(c) 2022 Marcio Alemão. All rights reserved."
    FunctionsToExport = @(
        'Get-RecycleBin',
        'Add-RecycleBin',
        'Clear-RecycleBin',
        'Restore-RecycleBin'
    )
    CmdletsToExport   = @(
        'Get-RecycleBin',
        'Add-RecycleBin',
        'Clear-RecycleBin',
        'Restore-RecycleBin'
    )
    VariablesToExport = '*'
    AliasesToExport   = @(
        'trash-list',
        'trash-put',
        'trash-clear',
        'trash-restore'
    )
    PrivateData       = @{
        PSData = @{
            Tags       = @('PSTrash', 'RecycleBin', 'Windows', 'File', 'Management')
            ProjectUri = 'https://github.com/marcio1002/Register-AutocompleteCommand'
            LicenseUri = 'https://github.com/marcio1002/Register-AutocompleteCommand/blob/master/LICENCE.MD'

        }
    }
}