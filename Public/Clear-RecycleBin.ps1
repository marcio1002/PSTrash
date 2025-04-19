
function Clear-RecycleBin {
    <#
        .SYNOPSIS

        .PARAMETER paths

        .EXAMPLE

        .DESCRIPTION
    #>
    param(
        [Parameter(Mandatory = $false)]
        [string]
        $file = "*"
    )

    $shell = New-Object -ComObject Shell.Application
    $TRASH = 10
    $trash = $shell.Namespace($TRASH);

    if ($trash.Items().Count -eq 0) {
        Write-Host -ForegroundColor Yellow "Lixeira vazia"
        return
    }

    $trash.Items() | Where-Object { $_.Name -like "$file" } | ForEach-Object {
        Write-Host -ForegroundColor Yellow "Removendo da lixeira: $($_.Name)"
        Remove-Item -Path $_.Path -Force -ErrorAction SilentlyContinue 
    }

    if ($trash.Items().Count -eq 0) {
        Write-Host -ForegroundColor Green "Lixeira limpa"
    }
}
