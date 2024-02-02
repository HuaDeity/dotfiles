function CheckAndInstallModule {
    param (
        [string]$ModuleName
    )

    $module = Get-Module -ListAvailable -Name $ModuleName
    if ($null -eq $module) {
        Write-Host "Module $ModuleName is not installed. Attempting to install..."
        Install-Module -Name $ModuleName -Scope CurrentUser -Force -AllowClobber
    }
    Import-Module $ModuleName
}

CheckAndInstallModule "powershell-windows-autoproxy"
CheckAndInstallModule "Terminal-Icons"
CheckAndInstallModule "posh-git"

if ((Get-ItemPropertyValue -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme') -eq 0) {
    $env:flavour = "mocha"
} else {
    $env:flavour = "latte"
}

$ompConfigPath = Join-Path (Split-Path $PROFILE.CurrentUserCurrentHost) "catppuccin.omp.json"
oh-my-posh init pwsh --config $ompConfigPath | Invoke-Expression
