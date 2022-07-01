#!/usr/bin/bash
cd "$(dirname "$0")"

set -e

BLACK=$'\e[0;30m'
WHITE=$'\e[0;37m'
BWHITE=$'\e[1;37m'
RED=$'\e[0;31m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

PLUGIN_PATH="../src/plugins"
ENGINE_PATH="../src/purpur.jar"

GITHUB_PLUGINS=(
    "MilkBowl/Vault"
    "SkinsRestorer/SkinsRestorerX"
    "Nuytemans-Dieter/BetterSleeping"
    "NEZNAMY/TAB"
    "AuthMe/AuthMeReloaded"
)

FILE_PLUGINS=(
    "https://dev.bukkit.org/projects/worldedit/files/latest;WorldEdit"
    "https://dev.bukkit.org/projects/worldguard/files/latest;WorldGuard"
    "https://dev.bukkit.org/projects/player-heads/files/latest;PlayerHeads"
    "https://dev.bukkit.org/projects/coreprotect/files/latest;CoreProtect"
    "https://repo.ranull.com/minecraft/plugins/released/Graves/Graves-DEV.jar;Graves"
)

rm -f ../src/purpur.jar
rm -rf ../src/plugins/*.jar

i=1
maxi=$(expr ${#GITHUB_PLUGINS[@]} + 1 + 2 + 1 + ${#FILE_PLUGINS[@]}) # GitHub plugins + LuckPerms + EssentialsX and EssentialsXChat + Chunky + File plugins

# Download purpur
printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}purpur engine${BWHITE}...${NC}"
wget -qLO "${ENGINE_PATH}" "https://api.purpurmc.org/v2/purpur/1.18.2/latest/download"
printf "\r${GREEN}:: ${BWHITE}Succesfully downloaded ${BLUE}purpur${BWHITE}!${NC}\n"

function downloadLatestReleases() {
    PLUGIN_SPLIT=(${1//\// })
    PLUGIN_NAME=${PLUGIN_SPLIT[1]}
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}${PLUGIN_NAME}${BWHITE}...${NC}"
    curl -s "https://api.github.com/repos/$1/releases/latest" |
        grep browser_download_url |
        cut -d : -f 2,3 |
        tr -d \" |
        wget -O "${PLUGIN_PATH}/${PLUGIN_NAME}.jar" -qLi -
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}${PLUGIN_NAME}${BWHITE}!${NC}\n"
    ((i += 1))

}

function downloadLatestBuild() {
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}${2}${BWHITE}...${NC}"
    curl -s $1 |
        grep -Po "$2-.*?\.jar" |
        head -n 1 |
        sed "s#^#${1}#" |
        wget -O "${PLUGIN_PATH}/${2}.jar" -qi -
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}${2}${BWHITE}!${NC}\n"
    ((i += 1))
}

function downloadLatestFile() {
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}${2}${BWHITE}...${NC}"
    wget -qLO "${PLUGIN_PATH}/${2}.jar" "${1}"
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}${2}${BWHITE}!${NC}\n"
    ((i += 1))
}

function downloadEssentialsX() {
    res=$(curl -s "https://ci-api.essentialsx.net/job/EssentialsX/lastSuccessfulBuild/api/json")
    url=$(echo $res | jq '.url' -r)
    path1=$(echo $res | jq '.artifacts[0].relativePath' -r) # Get EssentialX
    path2=$(echo $res | jq '.artifacts[2].relativePath' -r) # Get EssentialXChat
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}EssentialsX${BWHITE}...${NC}"
    wget -qO "${PLUGIN_PATH}/EssentialsX.jar" "${url}artifact/${path1}"
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}EssentialsX${BWHITE}!${NC}\n"
    ((i += 1))
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}EssenstialsXChat${BWHITE}...${NC}"
    wget -qO "${PLUGIN_PATH}/EssenstialsXChat.jar" "${url}artifact/${path2}"
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}EssenstialsXChat${BWHITE}!${NC}\n"
    ((i += 1))
}

function downloadLatestFile() {
    printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}${2}${BWHITE}...${NC}"
    wget -qLO "${PLUGIN_PATH}/${2}.jar" "${1}"
    printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}${2}${BWHITE}!${NC}\n"
    ((i += 1))
}

for PLUGIN in "${GITHUB_PLUGINS[@]}"; do
    downloadLatestReleases $PLUGIN
done

# Download latest LuckPerms
printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}LuckPerms${BWHITE}...${NC}"
LP_URL=$(curl -s https://metadata.luckperms.net/data/downloads | jq '.downloads.bukkit' -r)
wget -qO "${PLUGIN_PATH}/LuckPerms.jar" $LP_URL
printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}LuckPerms${BWHITE}!${NC}\n"
((i += 1))

# Download EssentialsX and EssentialsXChat
downloadEssentialsX

# Download Chunky
downloadLatestBuild "https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/" "Chunky"

for PLUGIN_PAIR in "${FILE_PLUGINS[@]}"; do
    downloadLatestFile ${PLUGIN_PAIR//;/ }
done
