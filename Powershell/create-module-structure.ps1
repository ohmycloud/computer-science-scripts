$ModuleName = 'BackFillTool'
$ModuleVersion = "1.0.0.0"
$Author = "thinkenergy"
$PSVersion = '7.2.1'
$PSModulePath = $env:PSModulePath.split(':')[0]
$ModulePath = Join-Path $PSModulePath "$($ModuleName)\$($ModuleVersion)"

New-Item -Path $ModulePath -ItemType Directory
Set-Location $ModulePath
New-Item -Path .\Public -ItemType Directory

$ManifestParameters = @{
    ModuleVersion = $ModuleVersion
    Author = $Author
    Path = ".\$($ModuleName).psd1"
    RootModule = ".\$($ModuleName).psm1"
    PowerShellVersion = $PSVersion
}

New-ModuleManifest @ManifestParameters
Out-File -Path ".\$($ModuleName).psm1" -Encoding utf8
