$clsid = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"

if (Test-Path $clsid) {
    Remove-Item -Path $clsid -Recurse -Force
    Write-Host "Switched to NEW right click menu"
} else {
    New-Item -Path $clsid -Force | Out-Null
    New-Item -Path "$clsid\InprocServer32" -Force | Out-Null
    Set-ItemProperty -Path "$clsid\InprocServer32" -Name "(default)" -Value ""
    Write-Host "Switched to CLASSIC right click menu"
}

Stop-Process -Name explorer -Force
Start-Process explorer.exe
