function Restore-RecycleBin {
    <#
        .SYNOPSIS

        .PARAMETER paths

        .EXAMPLE

        .DESCRIPTION
    #>
    param(
        [Parameter(Mandatory = $false)]
        [string]
        $file
    )

    $shell = New-Object -ComObject Shell.Application
    $TRASH = 10
    $trash = $shell.Namespace($TRASH)

    if ($trash.Items().Count -eq 0) {
        Write-Host -ForegroundColor Yellow "Lixeira vazia"
        return
    }

    $files = $trash.Items() | Where-Object { $_.Name -like "$file" }
            
    if ($files.Count -eq 0) {
        Write-Host -ForegroundColor Red "Arquivo não encontrado na lixeira"
    }

    $files | ForEach-Object {
        [Microsoft.VisualBasic.FileIO.FileSystem]::MoveFile(
            $_.Path,
            $_.GetFolder.Title,
            'OnlyErrorDialogs'
        )

        Write-Host -ForegroundColor Green "Arquivo ($_.Name) restaurado"
    }
}