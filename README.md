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

**Silnik** - [Purpur 1.17.1](https://purpur.pl3x.net/)

**Pluginy** :

- AuthMe
- BetterSleeping
- EssentialsX
- EssentialX Chat
- LuckPerms
- PlayerHeads
- SkinRestorer
- TAB
- Vault
- WorldEdit
- WorldGuard

## Instalacja

**Wymagania :**

- [git](https://git-scm.com/)
- PowerShell

### 1. Pobieranie plików

```git
git clone https://github.com/kamack38/mcServer
```

### 2. Instalowanie silnika oraz pluginów

Żeby serwer zadziałał, należy pobrać silnik oraz pluginy. Aby tego dokonać należy uruchomić plik [`download.latest.ps1`](./src/download.latest.ps1)

### 3.1 Uruchamianie Serwera

Jeśli chcesz grać w trybie lokalnym uruchom plik [`run.bat`](./src/run.bat).

### 3.2 Serwer w trybie Online

1. Pobierz program [ngrok](https://ngrok.com) i dokończ wszystkie kroki instalacyjne.
2. Użyj komendy :

```powershell
./ngrok tcp -region eu 25565
```

3. Jeśli chcesz by ip twojego serwera wysłało się na Discord automatycznie:
    - Utwórz webhook
    - Umieść jego link w pliku `token.env.example`
    - Zmień nazwę pliku na `token.env`.
4. Uruchom plik `ngrok.ps1`

## Przypisy

[Paper Anti-Xray settings by stonar96](https://gist.github.com/stonar96/ba18568bd91e5afd590e8038d14e245e)
