# Delete Old plugins
Remove-Item .\purpur.jar
Remove-Item .\plugins\*.jar

# Download purpur
curl "https://api.pl3x.net/v2/purpur/1.17.1/latest/download" -o purpur.jar

# Download latest MilkBowl/Vault release from github
$repo = "MilkBowl/Vault"
$releases = "https://api.github.com/repos/$repo/releases"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$file = "Vault.jar"
$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$jar = "plugins\$name-$tag.jar"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download -Out $jar

# Download latest SkinsRestorer/SkinsRestorerX release from github
$repo = "SkinsRestorer/SkinsRestorerX"
$releases = "https://api.github.com/repos/$repo/releases"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$file = "SkinsRestorer.jar"
$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$jar = "plugins\$name-$tag.jar"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download -Out $jar

# Download latest Nuytemans-Dieter/BetterSleeping release from github
$repo = "Nuytemans-Dieter/BetterSleeping"
$releases = "https://api.github.com/repos/$repo/releases"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$file = "BetterSleeping.jar"
$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$jar = "plugins\$name-$tag.jar"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download -Out $jar

# Download latest NEZNAMY/TAB release from github
$repo = "NEZNAMY/TAB"
$releases = "https://api.github.com/repos/$repo/releases"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$file = "TAB.v$tag.jar"
$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$jar = "plugins\$name-$tag.jar"

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
$link = (Invoke-WebRequest -Uri "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/").Links | Where-Object href -Match "^EssentialsX-.*" | Select-Object -first 1
$link = $link.href
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/$link" -Out plugins\$link

# Download EssenstialsXChat
$link = (Invoke-WebRequest -Uri "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/").Links | Where-Object href -Match "^EssentialsXChat-.*" | Select-Object -first 1
$link = $link.href
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/$link" -Out plugins\$link

# Download Chunky
$link = (Invoke-WebRequest -Uri "https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/").Links | Where-Object href -Match "^Chunky-.*" | Select-Object -first 1
$link = $link.href
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/" -Out plugins\$link

# Download WorldEdit
Invoke-WebRequest "https://dev.bukkit.org/projects/worldedit/files/latest" -Out plugins\WorldEdit.jar

# Download WorldGuard
Invoke-WebRequest "https://dev.bukkit.org/projects/worldguard/files/latest" -Out plugins\WorldGuard.jar

# Download PlayerHeads
Invoke-WebRequest "https://dev.bukkit.org/projects/player-heads/files/latest" -Out plugins\PlayerHeads.jar

# Download CoreProtect
Invoke-WebRequest "https://dev.bukkit.org/projects/coreprotect/files/latest" -Out plugins\CoreProtect.jar

# Download graves
Invoke-WebRequest "https://repo.ranull.com/maven/ranull/com/ranull/Graves/DEV/Graves-DEV.jar" -Out plugins\Graves.jar
