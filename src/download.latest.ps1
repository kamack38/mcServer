param (
    [switch]$nonpremium,
    [switch]$nightly
)

$error.clear()

# Delete Old plugins
Remove-Item .\purpur.jar
Remove-Item .\plugins\*.jar

# Speed up download
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Continue'

# Download purpur
curl "https://api.purpurmc.org/v2/purpur/1.18.2/latest/download" -o purpur.jar

function Get-LatestGitHubRelease($repo, $file, $noV) {
    $releases = "https://api.github.com/repos/$repo/releases"
    
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name
    
    $file = $file.Replace('$tag', "$tag")
    
    if ($noV) {
        $file = $file.Replace('v', '')
    }
    
    $download = "https://github.com/$repo/releases/download/$tag/$file"
    $name = $file.Split(".")[0]
    $jar = "plugins\$name-$tag.jar"
    
    Write-Output "Downloading $file from $repo..."
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest $download -Out $jar
    if ($?) {
        Write-Host  "File $file at $tag has been successfully downloaded from $repo" -Foreground green
    }
    else {
        Write-Host  "Error downloading $file at $tag from $repo" -Foreground red
    }
}

$githubPluginsList = @(
    [pscustomobject]@{Repo = "MilkBowl/Vault"; File = "Vault.jar"; noV = 0 }
    [pscustomobject]@{Repo = "SkinsRestorer/SkinsRestorerX"; File = "SkinsRestorer.jar"; noV = 0 }
    [pscustomobject]@{Repo = "Nuytemans-Dieter/BetterSleeping"; File = "BetterSleeping.jar"; noV = 0 }
    [pscustomobject]@{Repo = "NEZNAMY/TAB"; File = 'TAB.v$tag.jar'; noV = 0 }
    [pscustomobject]@{Repo = "PlayPro/CoreProtect"; File = 'CoreProtect-$tag.jar'; noV = 1 }
)

if ($nonpremium) {
    $githubPluginsList += [pscustomobject]@{Repo = "AuthMe/AuthMeReloaded"; File = 'AuthMe-$tag.jar'; noV = 0 }
}

foreach ($item in $githubPluginsList) {
    Get-LatestGitHubRelease $item.Repo $item.File $item.noV
}

# Download latest LuckPerms
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$download = (Invoke-WebRequest -Uri "https://metadata.luckperms.net/data/downloads" -UseBasicParsing | ConvertFrom-Json)

$file = $download.downloads.bukkit.Split('/')[-1]
$repo = 'ci.lucko.me'
Write-Output "Downloading $file from $repo"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download.downloads.bukkit -Out "plugins\$file"

if ($?) {
    Write-Host  "File $file has been successfully downloaded from $repo" -Foreground green
}
else {
    Write-Host  "Error downloading $file from $repo" -Foreground red
}
function Get-LatestPlugin($url, $file) {
    $file = ((Invoke-WebRequest -Uri "$url").Links | Where-Object href -Match "$file" | Select-Object -first 1).href
    if ($null -ne $file.Split('/')[1]) {
        $url = ($file -split "/", -2)[0] + '/'
        $file = $file.Split('/')[-1].Split('?')[0]
    }
    $domain = $url.Split('/')[2]
    Write-Output "Downloading $file from $domain"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest ($url + $file) -Out "plugins\$file" -ErrorAction SilentlyContinue
    if ($?) {
        Write-Host  "File $file has been successfully downloaded from $domain" -Foreground green
    }
    else {
        Write-Host  "Error downloading $file from $domain" -Foreground red
    }
}

$pluginsList = @(
    [pscustomobject]@{url = "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/"; file = "^EssentialsX-.*" }
    [pscustomobject]@{url = "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/"; file = "^EssentialsXChat-.*" }
    [pscustomobject]@{url = "https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/"; file = "^Chunky-.*" }
)

if ($nightly) {
    $pluginsList += @(
        [pscustomobject]@{url = "https://ci.meme.tips/job/PlayerHeads-5.x/lastSuccessfulBuild/artifact/target/"; file = "PlayerHeads-.*-SNAPSHOT*" }
        # Not working
        # [pscustomobject]@{url = "https://builds.enginehub.org/job/worldedit/last-successful?branch=master"; file = "worldedit-bukkit-*" }
        # [pscustomobject]@{url = "https://builds.enginehub.org/job/worldguard/last-successful?branch=master"; file = "worldguard-bukkit-*" }
    )
}
else {
    Invoke-WebRequest "https://dev.bukkit.org/projects/worldedit/files/latest" -Out plugins\WorldEdit.jar
    Invoke-WebRequest "https://dev.bukkit.org/projects/worldguard/files/latest" -Out plugins\WorldGuard.jar
    Invoke-WebRequest "https://dev.bukkit.org/projects/player-heads/files/latest" -Out "plugins\PlayerHeads.jar"
}

foreach ($item in $pluginsList) {
    Get-LatestPlugin $item.url $item.file
}

# Download graves
Invoke-WebRequest "https://repo.ranull.com/ranull/com/ranull/graves/DEV/Graves-DEV.jar" -Out "plugins\Graves-DEV.jar"

$errors = $error.count

if ($errors -eq 0) {
    Write-Host  "All files has been succesfully downloaded" -Foreground green
}
elseif ($errors -eq 1) {
    Write-Host  "Script has been executed with $errors error" -Foreground red
}
else {
    Write-Host  "Script has been executed with $errors errors" -Foreground red
    pause
    $error
}