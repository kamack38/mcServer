# Delete Old plugins
Remove-Item .\purpur.jar
Remove-Item .\plugins\*.jar

# Speed up download
$ProgressPreference = 'SilentlyContinue'

# Download purpur
curl "https://api.purpurmc.org/v2/purpur/1.17.1/latest/download" -o purpur.jar

function Get-LatestGitHubRelease($repo, $file) {
    $releases = "https://api.github.com/repos/$repo/releases"

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

    $file = $file.Replace('$tag', "$tag")

    $download = "https://github.com/$repo/releases/download/$tag/$file"
    $name = $file.Split(".")[0]
    $jar = "plugins\$name-$tag.jar"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest $download -Out $jar
}
# # Download latest MilkBowl/Vault release from github
Get-LatestGitHubRelease "MilkBowl/Vault" "Vault.jar"

# # Download latest SkinsRestorer/SkinsRestorerX release from github
Get-LatestGitHubRelease "SkinsRestorer/SkinsRestorerX" "SkinsRestorer.jar"

# # Download latest Nuytemans-Dieter/BetterSleeping release from github
Get-LatestGitHubRelease "Nuytemans-Dieter/BetterSleeping" "BetterSleeping.jar"

# # Download latest NEZNAMY/TAB release from github
Get-LatestGitHubRelease "NEZNAMY/TAB" 'TAB.v$tag.jar'

# Download latest AuthMe/AuthMeReloaded release from github
Get-LatestGitHubRelease "AuthMe/AuthMeReloaded" 'AuthMe-$tag.jar'

# Download latest LuckPerms
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$download = (Invoke-WebRequest -Uri "https://metadata.luckperms.net/data/downloads" -UseBasicParsing | ConvertFrom-Json)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download.downloads.bukkit -Out plugins\LuckPerms-Bukkit.jar

function Get-LatestPlugin($url, $file) {
    $link = (Invoke-WebRequest -Uri "$url").Links | Where-Object href -Match "$file" | Select-Object -first 1
    $link = $link.href
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest ($url + $link) -Out plugins\$link
}

# Download EssenstialsX
Get-LatestPlugin "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/" "^EssentialsX-.*"

# Download EssenstialsXChat
Get-LatestPlugin "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/" "^EssentialsXChat-.*"

# Download Chunky
Get-LatestPlugin "https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/" "^Chunky-.*"

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
