function Get-RecycleBin {
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
    $trash = $shell.Namespace($TRASH)

    if ($trash.Items().Count -eq 0) {
        Write-Host -ForegroundColor Yellow "Lixeira vazia"
        return
    }

    $items = $trash.Items() | Where-Object { $_.Name -ilike "$file" } | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.Name
            Path = $_.Path
            Date = $_.ModifyDate
            Size = $_.Size
        }
    } | Sort-Object -Property Date -Descending | Format-List

    $items
}