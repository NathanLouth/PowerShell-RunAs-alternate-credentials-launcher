$ActionDisplayName = "Run as Different User (Elevated)"

$CommandValue      = @'
powershell.exe -NoProfile -Command "& { param($File); $Credential = Get-Credential; Start-Process powershell.exe -Credential $Credential -WorkingDirectory 'C:\' -ArgumentList \"-NoProfile Start-Process '$($File)' -Verb RunAs \"}" \"%1\"
'@

$basePath    = "HKCU:\Software\Classes\*\shell"
$subKey      = "RunAsCustomCredElevated"
$commandKey  = "command"

$actionPath  = Join-Path $basePath $subKey
$commandPath = Join-Path $actionPath $commandKey

if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -Force | Out-Null
}

if (-not (Test-Path $actionPath)) {
    New-Item -Path $actionPath -Force | Out-Null
}

Set-ItemProperty -Path $actionPath -Name "(default)" -Value $ActionDisplayName
Set-ItemProperty -Path $actionPath -Name "HasLUAShield" -Value ""

if (-not (Test-Path $commandPath)) {
    New-Item -Path $commandPath -Force | Out-Null
}

Set-ItemProperty -Path $commandPath -Name "(default)" -Value $CommandValue
