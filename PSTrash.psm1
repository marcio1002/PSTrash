Get-ChildItem -Path "$PSScriptRoot\Public" -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}

New-Alias -Name trash-list -Value Get-RecycleBin -Option AllScope -Description "Pega os arquivos da lixeira, você pode passar um parâmetro para filtrar por expressão regular"
New-Alias -Name trash-put -Value Add-RecycleBin -Option AllScope -Description "Adicionar um item na lixeira"
New-Alias -Name trash-clear -Value Clear-RecycleBin -Option AllScope -Description "Limpa todos os items da lixeira, você pode passar um parâmetro para filtrar por expressão regular"
New-Alias -Name trash-restore -Value Restore-RecycleBin -Option AllScope -Description "Restaura um item da lixeira, vocé pode passar um parâmetro para filtrar por expressão regular"