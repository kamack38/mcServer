rm -f purpur.jar
rm -rf plugins/.*.jar

# Download purpur
wget -o purpur.jar "https://api.pl3x.net/v2/purpur/1.17.1/latest/download"

# Download WorldEdit
wget -o plugins/WorldEdit.jar "https://dev.bukkit.org/projects/worldedit/files/latest"

# Download WorldGuard
wget -o plugins/WorldGuard.jar "https://dev.bukkit.org/projects/worldguard/files/latest"

# Download PlayerHeads
wget -o plugins/PlayerHeads.jar "https://dev.bukkit.org/projects/player-heads/files/latest"

# Download CoreProtect
wget -o plugins/CoreProtect.jar "https://dev.bukkit.org/projects/coreprotect/files/latest"

# Download Graves
wget -o plugins/Graves.jar "https://repo.ranull.com/maven/ranull/com/ranull/Graves/DEV/Graves-DEV.jar"

# Download latest MilkBowl/Vault release from github
curl -s "https://api.github.com/repos/MilkBowl/Vault/releases" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

# Download latest SkinsRestorer/SkinsRestorerX release from github
curl -s "https://api.github.com/repos/SkinsRestorer/SkinsRestorerX/releases/latest" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

# Download latest Nuytemans-Dieter/BetterSleeping release from github
curl -s "https://api.github.com/repos/Nuytemans-Dieter/BetterSleeping/releases/latest" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

# Download latest NEZNAMY/TAB release from github
curl -s "https://api.github.com/repos/NEZNAMY/TAB/releases/latest" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

# Download latest AuthMe/AuthMeReloaded release from github
curl -s "https://api.github.com/repos/AuthMe/AuthMeReloaded/releases/latest" |
    grep browser_download_url |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

# Download latest LuckPerms
curl -s "https://metadata.luckperms.net/data/downloads" |
    grep bukkit |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

# Download EssenstialsX
curl -s "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/" |
    grep "EssentialsX-.*?(\.jar)" |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

# Download EssenstialsXChat
curl -s "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/" |
    grep "EssentialsXChat-.*?(\.jar)" |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

# Download Chunky
wget -o plugins/Chunky.jar "https://www.spigotmc.org/resources/chunky.81534/download?version=402563"
