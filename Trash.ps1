function Get-RecycleBin {
    param(
        [Parameter(Mandatory=$false)]
        [string]
        $file="*"
    )

    $shell = New-Object -ComObject Shell.Application
    $TRASH = 10
    $trash = $shell.Namespace($TRASH)

    if ($trash.Items().Count -eq 0) {
        Write-Host -ForegroundColor Yellow "Lixeira vazia"
        return
    }

    $items = $trash.Items() | Where-Object {$_.Name -ilike "$file"} | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.Name
            Path = $_.Path
            Date = $_.ModifyDate
            Size = $_.Size
        }
    } | Sort-Object -Property Date -Descending | Format-List

    $items
}
New-Alias -Name trash-list -Value Get-RecycleBin -Option AllScope -Description "Pega os arquivos da lixeira, você pode passar um parâmetro para filtrar por expressão regular"

function Clear-RecycleBin {
    param(
        [Parameter(Mandatory=$false)]
        [string]
        $file="*"
    )

    $shell = New-Object -ComObject Shell.Application
    $TRASH = 10
    $trash = $shell.Namespace($TRASH);

    if ($trash.Items().Count -eq 0) {
        Write-Host -ForegroundColor Yellow "Lixeira vazia"
        return
    }

    $trash.Items() | Where-Object {$_.Name -like "$file"} | ForEach-Object {
        Write-Host -ForegroundColor Yellow "Removendo da lixeira: $($_.Name)"
        Remove-Item -Path $_.Path -Force -ErrorAction SilentlyContinue 
    }

    if($trash.Items().Count -eq 0) {
        Write-Host -ForegroundColor Green "Lixeira limpa"
    }
}
New-Alias -Name trash-clear -Value Clear-RecycleBin -Option AllScope -Description "Limpa todos os items da lixeira, você pode passar um parâmetro para filtrar por expressão regular"

function Add-RecycleBin {
    param(
        [Parameter(Mandatory=$true)]
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
        } else {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile(
                $item,
                'OnlyErrorDialogs',
                'SendToRecycleBin'
            )
        }

        Write-Host -ForegroundColor Green "Item $($item) movido para lixeira"
    }
}
New-Alias -Name trash-put -Value Add-RecycleBin -Option AllScope -Description "Adicionar um item na lixeira"