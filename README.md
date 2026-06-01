# BIOS Arbeitszeit — Releases

Öffentliche Release-Artefakte (Windows-Installer + Update-Metadaten) der
**BIOS-Arbeitszeit**-Electron-App für den BIOS Naturmarkt Göggingen.

Der Quellcode liegt im **privaten** Hauptrepository. Dieses Repo enthält
ausschließlich die von `electron-builder` veröffentlichten Release-Assets
(`*-admin-setup.exe`, `*.blockmap`, `latest.yml`), die der Auto-Updater
(`electron-updater`) der installierten App ausliest.

Die Releases werden manuell per `npm run release:admin:win` publiziert.

## Installation

1. Aktuelles Setup unter [**Releases**](../../releases/latest) herunterladen
   (`bios-arbeitszeit-<version>-admin-setup.exe`).
2. Die heruntergeladene Datei starten und dem Assistenten folgen.
   Bei der **Erstinstallation** lässt sich der Installationsordner frei wählen;
   spätere Updates werden automatisch am selben Ort installiert.

> **Hinweis zum Download:** Die Setup-Datei ist groß (~150 MB). Wird der
> Download abgebrochen, ist die Datei unvollständig und der Start meldet einen
> *„NSIS Error – Installer integrity check has failed"*. In dem Fall die Datei
> löschen und vollständig neu herunterladen.

## Problembehebung: lässt sich nicht mehr deinstallieren

Wird eine Installation **mittendrin abgebrochen**, kann ein unvollständiger
Zustand zurückbleiben: „BIOS Arbeitszeit Admin" steht zwar noch unter
*Windows > Apps*, lässt sich dort aber nicht mehr deinstallieren (der zugehörige
Uninstaller fehlt oder ist beschädigt).

Zum Bereinigen das Skript **[`bios-cleanup.ps1`](bios-cleanup.ps1)** verwenden:

1. Skript herunterladen (im Dateiverzeichnis auf `bios-cleanup.ps1` klicken →
   *Download raw file*).
2. **Rechtsklick** auf die Datei → **„Mit PowerShell ausführen"**.
3. Das Skript entfernt gezielt nur die BIOS-Arbeitszeit-Reste (Registry-Eintrag,
   Programmordner, Verknüpfungen). Administratorrechte sind nicht nötig.

Danach ist „BIOS Arbeitszeit Admin" entfernt und das Setup kann frisch gestartet
werden — dann erscheint auch wieder die Auswahl des Installationsordners.

Alternativ von Hand (ohne Skript):

- Ordner `%LOCALAPPDATA%\Programs\BIOS Arbeitszeit Admin` löschen.
- In `regedit` unter
  `HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall` den Schlüssel mit
  dem Anzeigenamen „BIOS Arbeitszeit Admin" löschen.
