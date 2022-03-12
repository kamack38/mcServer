#!/usr/bin/bash
cd "$(dirname "$0")"

Yellow='\033[1;33m'

rm -f purpur.jar
rm -rf plugins/*.jar

# Download purpur
wget -qLO purpur.jar "https://api.purpurmc.org/v2/purpur/1.18.2/latest/download"

# Download WorldEdit
wget -qLO plugins/WorldEdit.jar "https://dev.bukkit.org/projects/worldedit/files/latest"

# Download WorldGuard
wget -qLO plugins/WorldGuard.jar "https://dev.bukkit.org/projects/worldguard/files/latest"

# Download PlayerHeads
wget -qLO plugins/PlayerHeads.jar "https://dev.bukkit.org/projects/player-heads/files/latest"

# Download CoreProtect
wget -qLO plugins/CoreProtect.jar "https://dev.bukkit.org/projects/coreprotect/files/latest"

# Download Graves
wget -qLO plugins/Graves.jar "https://repo.ranull.com/maven/ranull/com/ranull/Graves/DEV/Graves-DEV.jar"

function donwloadLatestReleases() {
    # Split path
    pluginName=$(echo "${2##*/}")
    echo -e "${Yellow}Downloading ${pluginName}..."
    curl -s $1 |
        grep browser_download_url |
        cut -d : -f 2,3 |
        tr -d \" |
        wget -O $2 -qLi -
}

# Download latest MilkBowl/Vault release from github
downloadLatestReleases "https://api.github.com/repos/MilkBowl/Vault/releases" "plugins/Vault.jar"

# Download latest SkinsRestorer/SkinsRestorerX release from github
downloadLatestReleases "https://api.github.com/repos/SkinsRestorer/SkinsRestorerX/releases/latest" "plugins/SkinsRestorerX.jar"

# Download latest Nuytemans-Dieter/BetterSleeping release from github
downloadLatestReleases "https://api.github.com/repos/Nuytemans-Dieter/BetterSleeping/releases/latest" "plugins/BetterSleeping.jar"

# Download latest NEZNAMY/TAB release from github
downloadLatestReleases "https://api.github.com/repos/NEZNAMY/TAB/releases/latest" "plugins/TAB.jar"

# Download latest AuthMe/AuthMeReloaded release from github
downloadLatestReleases "https://api.github.com/repos/AuthMe/AuthMeReloaded/releases/latest" "plugins/AuthMeReloaded.jar"

# Download latest LuckPerms
downloadLatestReleases "https://metadata.luckperms.net/data/downloads" "plugins/LuckPerms.jar"

function downloadLatestFile() {
    curl -s $1 |
        grep -Po $2 |
        head -n 1 |
        sed "s/^/${1}/" |
        wget -O "plugins/${3}" -qi -
}

# Download EssenstialsX
curl -s "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/" |
    grep -Po "EssentialsX-.*?\.jar" |
    head -n 1 |
    sed 's/^/https:\/\/ci.ender.zone\/job\/EssentialsX\/lastSuccessfulBuild\/artifact\/jars\//' |
    wget -O plugins/EssentialsX.jar -qi -

# Download EssenstialsXChat
curl -s "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/" |
    grep -Po "EssentialsXChat-.*?\.jar" |
    head -n 1 |
    sed 's/^/https:\/\/ci.ender.zone\/job\/EssentialsX\/lastSuccessfulBuild\/artifact\/jars\//' |
    wget -O plugins/EssenstialsXChat.jar -qi -

# Download Chunky
curl -s "https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/" |
    grep -Po "Chunky-.*?\.jar" |
    head -n 1 |
    sed 's/^/https:\/\/ci.codemc.io\/view\/Author\/job\/pop4959\/job\/Chunky\/lastSuccessfulBuild\/artifact\/bukkit\/build\/libs\//' |
    wget -O plugins/Chunky.jar -qi -
