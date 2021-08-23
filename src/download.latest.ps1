# Download purpur
curl "https://api.pl3x.net/v2/purpur/1.17.1/latest/download" -o purpur.jar

# Download Vault
curl "https://github.com/MilkBowl/Vault/releases/latest/download/Vault.jar" -L -o plugins/Vault.jar

# Download SkinsRestorer
curl "https://github.com/SkinsRestorer/SkinsRestorerX/releases/latest/download/SkinsRestorer.jar" -L -o plugins/SkinsRestorer.jar

# Download BetterSleeping
curl "https://github.com/Nuytemans-Dieter/BetterSleeping/releases/latest/download/BetterSleeping.jar" -L -o plugins/SkinsRestorer.jar

# Download latest NEZNAMY/TAB release from github
$repo = "NEZNAMY/TAB"
$releases = "https://api.github.com/repos/$repo/releases"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$file = "TAB.v$tag.jar"
$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$jar = "plugins\$name.v$tag.jar"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download -Out $jar

# Download latest AuthMe/AuthMeReloaded release from github
$repo = "AuthMe/AuthMeReloaded"
$releases = "https://api.github.com/repos/$repo/releases"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$file = "AuthMe-$tag.jar"
$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$jar = "plugins\$name-$tag.jar"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download -Out $jar

# Download latest LuckPerms
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$download = (Invoke-WebRequest -Uri "https://metadata.luckperms.net/data/downloads" -UseBasicParsing | ConvertFrom-Json)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download.downloads.bukkit -Out plugins\LuckPerms-Bukkit.jar

# Download EssenstialsX
$link = (Invoke-WebRequest –Uri "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/").Links | Where-Object href -Match "^EssentialsX-.*" | Select-Object -first 1
$link = $link.href
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/$link" -Out plugins\$link

# Download EssenstialsXChat
$link = (Invoke-WebRequest –Uri "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/").Links | Where-Object href -Match "^EssentialsXChat-.*" | Select-Object -first 1
$link = $link.href
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/$link" -Out plugins\$link

explorer.exe https://www.spigotmc.org/resources/graves.74208/
explorer.exe https://www.spigotmc.org/resources/chunky.81534/
explorer.exe https://dev.bukkit.org/projects/worldedit/files/latest
explorer.exe https://dev.bukkit.org/projects/worldguard/files/latest
explorer.exe https://dev.bukkit.org/projects/player-heads/files/latest