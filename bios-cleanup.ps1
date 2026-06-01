# BIOS Arbeitszeit Admin – Reste einer abgebrochenen Installation entfernen
#
# Wann brauche ich das?
#   Wenn eine Installation abgebrochen wurde und sich "BIOS Arbeitszeit Admin"
#   danach nicht mehr normal über Windows > Apps deinstallieren lässt.
#   Das Skript entfernt gezielt nur die BIOS-Arbeitszeit-Reste (Registry-
#   Eintrag, Programmordner, Verknüpfungen) – sonst nichts.
#
# Ausführen:
#   Rechtsklick auf diese Datei > "Mit PowerShell ausführen"
#   – oder – in einer PowerShell-Konsole:  ./bios-cleanup.ps1
#   Es werden keine Administratorrechte benötigt (Installation pro Benutzer).

$ErrorActionPreference = 'SilentlyContinue'
$name = 'BIOS Arbeitszeit'

Write-Host "BIOS Arbeitszeit – Bereinigung gestartet ..." -ForegroundColor Cyan

# 1) Evtl. laufende App beenden
Get-Process | Where-Object { $_.Path -like "*$name*" } | Stop-Process -Force

# 2) Uninstall-Registry-Einträge durchsuchen
$roots = @(
  'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall',
  'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall',
  'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
)
foreach ($root in $roots) {
  Get-ChildItem $root | ForEach-Object {
    $p = Get-ItemProperty $_.PSPath
    if ($p.DisplayName -like "*$name*") {
      Write-Host "  Gefunden: $($p.DisplayName)"
      # Falls ein funktionierender Uninstaller da ist, zuerst diesen versuchen
      $exe = ($p.UninstallString -replace '"', '') -replace ' /currentuser', ''
      if ($exe -and (Test-Path $exe)) {
        Start-Process $exe -ArgumentList '/currentuser', '/S' -Wait
      }
      # Registry-Eintrag in jedem Fall entfernen (fängt auch verwaiste ab)
      Remove-Item $_.PSPath -Recurse -Force
      Write-Host "    Registry-Eintrag entfernt."
    }
  }
}

# 3) Programmordner entfernen
$dir = Join-Path $env:LOCALAPPDATA 'Programs\BIOS Arbeitszeit Admin'
if (Test-Path $dir) {
  Remove-Item $dir -Recurse -Force
  Write-Host "  Programmordner entfernt: $dir"
}

# 4) Start­menü- und Desktop-Verknüpfungen entfernen
Get-ChildItem "$env:APPDATA\Microsoft\Windows\Start Menu\Programs" -Recurse -Filter "*$name*" | Remove-Item -Force
Get-ChildItem "$env:USERPROFILE\Desktop" -Filter "*$name*" | Remove-Item -Force

Write-Host "`nFertig. 'BIOS Arbeitszeit Admin' sollte jetzt nicht mehr unter" -ForegroundColor Green
Write-Host "Windows > Apps erscheinen. Das Setup kann nun frisch gestartet werden." -ForegroundColor Green
