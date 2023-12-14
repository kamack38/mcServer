# mcServer

<p align="center">
    <img alt="Wersja Minecraft" src="https://img.shields.io/badge/Wersja%20minecraft-1.20.2-brightgreen?style=for-the-badge">
    <img alt="Liczba Pluginów" src="https://img.shields.io/badge/Pluginy-16-brightgreen?style=for-the-badge">
</p>

<!-- TOC -->

- [mcServer](#mcserver)
  - [Opis](#opis)
  - [Informacje](#informacje)
    - [Pluginy](#pluginy)
    - [Datapacki](#datapacki)
  - [Instalacja](#instalacja)
    - [1. Pobieranie plików](#1-pobieranie-plików)
    - [2. Instalowanie silnika oraz pluginów](#2-instalowanie-silnika-oraz-pluginów)
    - [3.1 Uruchamianie Serwera](#31-uruchamianie-serwera)
    - [3.2 Serwer w trybie Online](#32-serwer-w-trybie-online)
    - [3.3 Uruchamianie za pomocą dockera](#33-uruchamianie-za-pomocą-dockera)
  - [Dodatkowa konfiguracja](#dodatkowa-konfiguracja)
  - [Dodatkowe informacje](#dodatkowe-informacje)
  - [Credits](#credits)

<!-- /TOC -->

## Opis

To repozytorium zawiera wszelkie potrzebne pliki konfiguracyjne na twój serwer minecraft.

## Informacje

**Wspierane systemy :**

- Linux
- Windows 10/11

**Silnik** - [Purpur 1.20.1](https://purpurmc.org/)

<details> 
  <summary><h3>Pluginy</h3></summary>

- [AuthMe](https://github.com/AuthMe/AuthMeReloaded) (non-premium)
- [BetterSleeping](https://github.com/Nuytemans-Dieter/BetterSleeping)
- [Chunky](https://www.spigotmc.org/resources/chunky.81534/)
- [CoreProtect](https://github.com/PlayPro/CoreProtect)
- [EssentialsX](https://essentialsx.net/downloads.html)
- [EssentialX Chat](https://essentialsx.net/downloads.html)
- [Graves](https://www.spigotmc.org/resources/graves.74208/)
- [LuckPerms](https://luckperms.net/)
- [PlaceholderAPI](https://github.com/PlaceholderAPI/PlaceholderAPI)
- [PlayerHeads](https://dev.bukkit.org/projects/player-heads)
- [SkinRestorer](https://github.com/SkinsRestorer/SkinsRestorerX)
- [TAB](https://github.com/NEZNAMY/TAB)
- [Vault](https://www.spigotmc.org/resources/vault.34315/)
- [WorldEdit](https://dev.bukkit.org/projects/worldedit)
- [WorldGuard](https://dev.bukkit.org/projects/worldguard)

</details>

<details> 
  <summary><h3>Datapacki</h3></summary>

- Węgiel -> czarny barwnik
- Zapakowany lód -> zwykły lód
- Blok netherowej brodawki -> netherowa brodawka
- Wełna -> nici
- Schodki i półpłytki -> pełne bloki
- Przepalanie zgniłego mięsa do surowej wołowiny

</details>

## Instalacja

**Wymagania :**

- PowerShell / Bash (domyślnie te programy są zainstalowane na odpowiednich systemach operacyjnych)
- [Java](https://www.java.com/pl/download/) (min 8) / [OpenJDK](https://adoptium.net/?variant=openjdk17&jvmVariant=hotspot)
- [git](https://git-scm.com/) (opcjonalne)

**Wymagania Linux :**

- [jq](https://github.com/jqlang/jq)
- [wget](https://command-not-found.com/wget)

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

Korzystając z Windowsa możesz dodać parametr `-nonpremium` by włączyć serwer w tym trybie:

```powershell
.\download.latest.ps1 -nonpremium
```

### 3.1 Uruchamianie Serwera

- Jeśli chcesz grać w trybie lokalnym uruchom plik [`run.bat`](./src/run.bat) lub [`run.sh`](./src/run.sh).

- Jeśli preferujesz uruchomić serwer prosto z linii komend wpisz:

```powershell
java -Xmx4096M -Xms4096M -jar purpur.jar nogui
```

**UWAGA!** Powyższa opcja nie jest zalecana, ponieważ nie używa ona wszystkich optymalizacji. Korzystając z niej pamiętaj, żeby znajdować się w odpowiedniej ścieżce, by plik `purpur.jar` mógł zostać znaleziony.

**Jeśli chcesz by inne osoby z twojej sieci mogły dołączyć do twojego serwera to pamiętaj, aby mieć otworzony port `25565`**(jest to domyślny port, którego używa serwer jeśli go wcześniej nie zmieniłeś)**!**

> Jeśli nie wiesz jak to zrobić kliknij [tutaj](https://github.com/kamack38/mcServer/wiki/Ustawienia-Zapory-w-systemie-Windows)

### 3.2 Serwer w trybie Online

1. Pobierz program [ngrok](https://ngrok.com) i dokończ wszystkie kroki instalacyjne.
2. Użyj komendy :

```powershell
./ngrok tcp -region eu 25565
```

<!-- markdownlint-disable ol-prefix -->

3. Jeśli chcesz by ip twojego serwera wysyłało się na Discord automatycznie (niedostępne na Linuxie 🐧):

   - Utwórz webhook na wybranym serwerze Discord
   - Umieść jego link w pliku `update_vars.ps1.example`
   - Zmień nazwę pliku na `update_vars.ps1`.

4. Uruchom plik `run.ps1` z parametrem `-ngrok`

Jeśli posiadasz program _ngrok_ w tzw. _PATH_ to możesz uruchomić serwer bez wcześniejszego włączania programu ngrok

```powershell
.\run.ps1 -ngrok
```

### 3.3 Uruchamianie za pomocą dockera

Uruchamianie serwera za pomocą dockera jest oparte o [to](https://github.com/itzg/docker-minecraft-server) repozytorium

```
docker compose up -d
```

Żeby zobaczyć logi użyj:

```
docker compose logs -f
```

Aby zatrzymać kontener użyj:

```
docker compose stop
```

Pełną dokumentacje można znaleźć [tutaj](https://docker-minecraft-server.readthedocs.io/en/latest/).

<!-- markdownlint-restore ol-prefix -->

## Dodatkowa konfiguracja

Konfigurację anti-xray znajdziesz pod [tym linkiem](https://docs.papermc.io/paper/anti-xray).

## Dodatkowe informacje

### Silnik

- [Dokumentacja Purpur](https://purpurmc.org/docs/)
- [Dokumentacja PaperMC](https://docs.papermc.io/paper)
- [Dokumentacja Pufferfish](https://docs.pufferfish.host/)
- [Wiki CraftBukkit](https://bukkit.fandom.com/wiki/Main_Page)

### Pluginy

- [Wiki BetterSleeping](https://github.com/Nuytemans-Dieter/BetterSleeping/wiki)
- [Wiki EssentialX](https://essentialsx.net/wiki/Home.html)
- [Wiki PlaceholderAPI](https://github.com/PlaceholderAPI/PlaceholderAPI/wiki)

## Credits

- Crafting tweaks - [Vanilla Tweaks](https://vanillatweaks.net/)
