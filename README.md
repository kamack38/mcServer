# mcServer

<!-- TOC -->

- [mcServer](#mcserver)
  - [Opis](#opis)
  - [Informacje](#informacje)
  - [Instalacja](#instalacja)
    - [1. Pobieranie plików](#1-pobieranie-plików)
    - [2. Instalowanie silnika oraz pluginów](#2-instalowanie-silnika-oraz-pluginów)
    - [3.1 Uruchamianie Serwera](#31-uruchamianie-serwera)
    - [3.2 Serwer w trybie Online](#32-serwer-w-trybie-online)
  - [Przypisy](#przypisy)

<!-- /TOC -->

## Opis

To repozytorium zawiera wszelkie potrzebne pliki konfiguracyjne na twój serwer minecraft.

## Informacje

**Wspierane systemy :**

- Linux
- Windows 10/11

**Silnik** - [Purpur 1.17.1](https://purpur.pl3x.net/)

**Pluginy** :

- [AuthMe](https://github.com/AuthMe/AuthMeReloaded)
- [BetterSleeping](https://github.com/Nuytemans-Dieter/BetterSleeping)
- [Chunky](https://www.spigotmc.org/resources/chunky.81534/)
- [CoreProtect](https://github.com/PlayPro/CoreProtect)
- [EssentialsX](https://essentialsx.net/downloads.html)
- [EssentialX Chat](https://essentialsx.net/downloads.html)
- [Graves](https://www.spigotmc.org/resources/graves.74208/)
- [LuckPerms](https://luckperms.net/)
- [PlayerHeads](https://dev.bukkit.org/projects/player-heads)
- [SkinRestorer](https://skinsrestorer.net/)
- [TAB](https://github.com/NEZNAMY/TAB)
- [Vault](https://www.spigotmc.org/resources/vault.34315/)
- [WorldEdit](https://dev.bukkit.org/projects/worldedit)
- [WorldGuard](https://dev.bukkit.org/projects/worldguard)

## Instalacja

**Wymagania :**

- PowerShell / Bash (domyślnie te programy są zainstalowane na odpowiednich systemach operacyjnych)
- [Java](https://www.java.com/pl/download/) (min 8) / [OpenJDK](https://adoptium.net/?variant=openjdk17&jvmVariant=hotspot)
- [git](https://git-scm.com/) (opcjonalne)

### 1. Pobieranie plików

Pobierz pliki:

- Klikając w [ten link](https://github.com/kamack38/mcServer/archive/refs/heads/main.zip) i wypakuj je do wybranego przez siebie folderu

- Lub z użyciem Git'a

```git
git clone https://github.com/kamack38/mcServer
```

- Albo wget'a

```bash
wget https://github.com/kamack38/mcServer/archive/refs/heads/main.zip
```

### 2. Instalowanie silnika oraz pluginów

Żeby serwer zadziałał, należy pobrać silnik oraz pluginy. Aby tego dokonać należy uruchomić plik [`download.latest.ps1`](./src/download.latest.ps1) lub jeśli korzystasz z Linux'a [`download.latest.sh`](./src/download.latest.sh).

### 3.1 Uruchamianie Serwera

- Jeśli chcesz grać w trybie lokalnym uruchom plik [`run.bat`](./src/run.bat) lub [`run.sh`](./src/run.sh).

- Jeśli preferujesz uruchomić serwer prosto z linii komend wpisz:

```powershell
java -Xmx4096M -Xms4096M -jar purpur.jar nogui
```

> Pamiętaj, żeby znajdywać się w odpowiedniej ścieżce

### 3.2 Serwer w trybie Online

1. Pobierz program [ngrok](https://ngrok.com) i dokończ wszystkie kroki instalacyjne.
2. Użyj komendy :

```powershell
./ngrok tcp -region eu 25565
```

3. Jeśli chcesz by ip twojego serwera wysyłało się na Discord automatycznie (niedostępne na Linuxie 🐧):

   - Utwórz webhook na wybranym serwerze Discord
   - Umieść jego link w pliku `update_vars.ps1.example`
   - Zmień nazwę pliku na `update_vars.ps1`.

4. Uruchom plik `ngrok.ps1`

## Przypisy

[Paper Anti-Xray settings by stonar96](https://gist.github.com/stonar96/ba18568bd91e5afd590e8038d14e245e)
