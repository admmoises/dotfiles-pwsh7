# PowerShell 7 Profile with Oh My Posh
# Criado para funcionar com o script install.ps1

# Importar PSReadLine para melhorar a experiência de linha de comando
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
    
    # Configurações do PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -BellStyle None
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# Configurar Oh My Posh
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    # Caminho para o tema personalizado
    $ThemePath = Join-Path $PSScriptRoot "oh-my-posh-theme.json"
    
    # Se o tema personalizado existe, usar ele, senão usar um tema padrão
    if (Test-Path $ThemePath) {
        oh-my-posh init pwsh --config $ThemePath | Invoke-Expression
        Write-Host "🎨 Tema personalizado carregado!" -ForegroundColor Green
    } else {
        # Usar tema padrão se o personalizado não existir
        oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression
        Write-Host "🎨 Tema padrão carregado!" -ForegroundColor Yellow
    }
} else {
    Write-Warning "⚠️  Oh My Posh não está instalado. Execute o script install.ps1 primeiro."
}

# Aliases úteis
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name la -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String
Set-Alias -Name which -Value Get-Command

# Função para mostrar informações do sistema
function Get-SystemInfo {
    Write-Host "💻 Sistema: $($PSVersionTable.Platform)" -ForegroundColor Cyan
    Write-Host "🐚 PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor Cyan
    Write-Host "👤 usuário: $env:USERNAME" -ForegroundColor Cyan
    Write-Host "📁 Diretório: $(Get-Location)" -ForegroundColor Cyan
}

# Função para limpar tela e mostrar informações
function Clear-Host {
    [System.Console]::Clear()
    Write-Host "🚀 PowerShell 7 + Oh My Posh" -ForegroundColor Magenta
    Write-Host "═══════════════════════════════" -ForegroundColor Magenta
}

# Mensagem de boas-vindas
Write-Host ""
Write-Host "🚀 PowerShell 7 Profile carregado!" -ForegroundColor Green
Write-Host "💡 Digite 'Get-SystemInfo' para ver informações do sistema" -ForegroundColor Yellow
Write-Host ""