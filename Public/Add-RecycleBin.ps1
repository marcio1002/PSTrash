
function Add-RecycleBin {
    <#
        .SYNOPSIS

        .PARAMETER paths

        .EXAMPLE

        .DESCRIPTION
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string[]]
        $paths
    )

    $paths | ForEach-Object {
        $item = $_ -replace "^.", $(Get-Location)

        if (-not (Test-Path -Path $item)) {
            Write-Host -ForegroundColor Red "Arquivo não encontrado: $($item)"
            continue
        }

        if (Test-Path -Path $item -PathType Container) {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory(
                $item,
                'OnlyErrorDialogs',
                'SendToRecycleBin'
            )
        }
        else {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile(
                $item,
                'OnlyErrorDialogs',
                'SendToRecycleBin'
            )
        }

        Write-Host -ForegroundColor Green "Item $($item) movido para lixeira"
    }
}