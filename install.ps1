#!/usr/bin/env pwsh
#Requires -Version 7.0

Write-Host "🚀 Instalando configuração PowerShell 7 + Oh My Posh..." -ForegroundColor Cyan

# Verificar PowerShell 7
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Error "❌ Este script requer PowerShell 7+"
    exit 1
}

# Verificar/Instalar Oh My Posh
if (!(Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Instalando Oh My Posh..." -ForegroundColor Yellow
    if ($IsWindows) {
        winget install JanDeDobbeleer.OhMyPosh -s winget
    } else {
        # Linux/macOS
        curl -s https://ohmyposh.dev/install.sh | bash -s
    }
}

# Instalar/Atualizar PSReadLine para pwsh 7
Install-Module PSReadLine -Force -SkipPublisherCheck

# Criar diretório de perfil pwsh 7
$ProfileDir = "$env:USERPROFILE\Documents\PowerShell"
if (!(Test-Path $ProfileDir)) {
    New-Item -ItemType Directory -Path $ProfileDir -Force
}

# Backup do perfil atual
$ProfilePath = "$ProfileDir\Microsoft.PowerShell_profile.ps1"
if (Test-Path $ProfilePath) {
    Copy-Item $ProfilePath "$ProfilePath.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
}

# Instalar configurações
Copy-Item ".\pwsh7-profile.ps1" $ProfilePath
Write-Host "📄 Perfil PowerShell 7 instalado" -ForegroundColor Green

Write-Host "✅ Configuração instalada! Reinicie o PowerShell 7." -ForegroundColor Green
Write-Host "💡 Execute: pwsh" -ForegroundColor Yellow
