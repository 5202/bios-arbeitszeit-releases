# BIOS Arbeitszeit — Releases

Öffentliche Release-Artefakte (Windows-Installer + Update-Metadaten) der
**BIOS-Arbeitszeit**-Electron-App für den BIOS Naturmarkt Göggingen.

Der Quellcode liegt im **privaten** Hauptrepository. Dieses Repo enthält
ausschließlich die von `electron-builder` veröffentlichten Release-Assets
(`*-admin-setup.exe`, `*.blockmap`, `latest.yml`), die der Auto-Updater
(`electron-updater`) der installierten App ausliest.

Die Releases werden manuell per `npm run release:admin:win` publiziert.
