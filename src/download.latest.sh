#!/usr/bin/bash
cd "$(dirname "$0")"

BLACK=$'\e[0;30m'
WHITE=$'\e[0;37m'
BWHITE=$'\e[1;37m'
RED=$'\e[0;31m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

rm -f purpur.jar
rm -rf plugins/*.jar

i=1
maxi=14

# Download purpur
printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}purpur engine${BWHITE}...${NC}"
wget -qLO purpur.jar "https://api.purpurmc.org/v2/purpur/1.18.2/latest/download"
printf "\r${GREEN}:: ${BWHITE}Succesfully downloaded ${BLUE}purpur${BWHITE}!${NC}\n"

function downloadLatestReleases() {
    # Split path
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}${2}${BWHITE}...${NC}"
    curl -s $1 |
        grep browser_download_url |
        cut -d : -f 2,3 |
        tr -d \" |
        wget -O "plugins/${2}.jar" -qLi -
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}${2}${BWHITE}!${NC}\n"
    ((i += 1))

}

# Download latest MilkBowl/Vault release from github
downloadLatestReleases "https://api.github.com/repos/MilkBowl/Vault/releases" "Vault"

# Download latest SkinsRestorer/SkinsRestorerX release from github
downloadLatestReleases "https://api.github.com/repos/SkinsRestorer/SkinsRestorerX/releases/latest" "SkinsRestorerX"

# Download latest Nuytemans-Dieter/BetterSleeping release from github
downloadLatestReleases "https://api.github.com/repos/Nuytemans-Dieter/BetterSleeping/releases/latest" "BetterSleeping"

# Download latest NEZNAMY/TAB release from github
downloadLatestReleases "https://api.github.com/repos/NEZNAMY/TAB/releases/latest" "TAB"

# Download latest AuthMe/AuthMeReloaded release from github
downloadLatestReleases "https://api.github.com/repos/AuthMe/AuthMeReloaded/releases/latest" "AuthMeReloaded"

# Download latest LuckPerms
downloadLatestReleases "https://metadata.luckperms.net/data/downloads" "LuckPerms"

function downloadLatestBuild() {
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}${2}${BWHITE}...${NC}"
    curl -s $1 |
        grep -Po "$2-.*?\.jar" |
        head -n 1 |
        sed "s#^#${1}#" |
        wget -O "plugins/${2}.jar" -qi -
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}${2}${BWHITE}!${NC}\n"
    ((i += 1))

}

# Download EssenstialsX
downloadLatestBuild "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/" "EssentialsX"

# Download EssenstialsXChat
downloadLatestBuild "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/" "EssenstialsXChat"

# Download Chunky
downloadLatestBuild "https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/" "Chunky"

function downloadLatestFile() {
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}${2}${BWHITE}...${NC}"
    wget -qLO "plugins/${2}.jar" "${1}"
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}${2}${BWHITE}!${NC}\n"
    ((i += 1))
}

# Download WorldEdit
downloadLatestFile "https://dev.bukkit.org/projects/worldedit/files/latest" "WorldEdit"

# Download WorldGuard
downloadLatestFile "https://dev.bukkit.org/projects/worldguard/files/latest" "WorldGuard"

# Download PlayerHeads
downloadLatestFile "https://dev.bukkit.org/projects/player-heads/files/latest" "PlayerHeads"

# Download CoreProtect
downloadLatestFile "https://dev.bukkit.org/projects/coreprotect/files/latest" "CoreProtect"

# Download Graves
downloadLatestFile "https://repo.ranull.com/maven/ranull/com/ranull/Graves/DEV/Graves-DEV.jar" "Graves"
