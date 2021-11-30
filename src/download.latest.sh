cd "$(dirname "$0")"

rm -f purpur.jar
rm -rf plugins/*.jar

# Download purpur
wget -qLO purpur.jar "https://api.pl3x.net/v2/purpur/1.17.1/latest/download"

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

# Download latest MilkBowl/Vault release from github
curl -s "https://api.github.com/repos/MilkBowl/Vault/releases" |
    grep browser_download_url |
    cut -d : -f 2,3 | 
    tr -d \" |
    wget -O plugins/Vault.jar -qLi -

# Download latest SkinsRestorer/SkinsRestorerX release from github
curl -s "https://api.github.com/repos/SkinsRestorer/SkinsRestorerX/releases/latest" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -O plugins/SkinsRestorerX.jar -qLi -

# Download latest Nuytemans-Dieter/BetterSleeping release from github
curl -s "https://api.github.com/repos/Nuytemans-Dieter/BetterSleeping/releases/latest" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -O plugins/BetterSleeping.jar -qLi -

# Download latest NEZNAMY/TAB release from github
curl -s "https://api.github.com/repos/NEZNAMY/TAB/releases/latest" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -O plugins/TAB.jar -qLi -
 
# Download latest AuthMe/AuthMeReloaded release from github
curl -s "https://api.github.com/repos/AuthMe/AuthMeReloaded/releases/latest" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -O plugins/AuthMeReloaded.jar -qLi -

# Download latest LuckPerms
curl -s "https://metadata.luckperms.net/data/downloads" |
    grep bukkit |
    cut -d : -f 3,4 |
    cut -d , -f 1 |
    tr -d \" |
    wget -O plugins/LuckPerms.jar -qLi -

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
