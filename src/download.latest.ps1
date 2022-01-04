param (
    [switch]$nonpremium
)

$error.clear()

# Delete Old plugins
Remove-Item .\purpur.jar
Remove-Item .\plugins\*.jar

# Speed up download
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Continue'

# Download purpur
curl "https://api.purpurmc.org/v2/purpur/1.18.1/latest/download" -o purpur.jar

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

$pluginsList = @(
    [pscustomobject]@{Repo = "MilkBowl/Vault"; File = "Vault.jar"; noV = 0 }
    [pscustomobject]@{Repo = "SkinsRestorer/SkinsRestorerX"; File = "SkinsRestorer.jar"; noV = 0 }
    [pscustomobject]@{Repo = "Nuytemans-Dieter/BetterSleeping"; File = "BetterSleeping.jar"; noV = 0 }
    [pscustomobject]@{Repo = "NEZNAMY/TAB"; File = 'TAB.v$tag.jar'; noV = 0 }
    [pscustomobject]@{Repo = "PlayPro/CoreProtect"; File = 'CoreProtect-$tag.jar'; noV = 1 }
)

if ($nonpremium) {
    $pluginsList += [pscustomobject]@{Repo = "AuthMe/AuthMeReloaded"; File = 'AuthMe-$tag.jar'; noV = 0 }
}

foreach ($item in $pluginsList) {
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

# Download graves
Invoke-WebRequest "https://repo.ranull.com/maven/ranull/com/ranull/Graves/DEV/Graves-DEV.jar" -Out "plugins\Graves-DEV.jar"

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