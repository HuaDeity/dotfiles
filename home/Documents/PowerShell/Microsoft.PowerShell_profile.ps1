Install-Module -Name powershell-windows-autoproxy -Repository PSGallery -Force
Install-Module -Name posh-git -Repository PSGallery -Force
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Import-Module powershell-windows-autoproxy
Import-Module Terminal-Icons
Import-Module posh-git
if ((Get-ItemPropertyValue -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme') -eq 0) {
    $env:flavour = "mocha"
} else {
    $env:flavour = "latte"
}
oh-my-posh init pwsh --config (Join-Path (Split-Path $PROFILE.CurrentUserCurrentHost) "catppuccin.omp.json") | Invoke-Expression
