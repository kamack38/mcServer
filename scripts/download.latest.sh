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
maxi=$((${#GITHUB_PLUGINS[@]} + 1 + 2 + 1 + ${#FILE_PLUGINS[@]})) # GitHub plugins + LuckPerms + EssentialsX and EssentialsXChat + Chunky + File plugins

print_downloading() {
	printf "\r${BLUE}:: ${BWHITE}Downloading ${BLUE}${1}${BWHITE}...${NC}"
}

print_downloaded() {
	printf "\r${GREEN}:: ${NC}[$i/$maxi] ${BWHITE}Succesfully downloaded ${BLUE}${1}${BWHITE}!${NC}\n"
	((i += 1))
}

# Download purpur
print_downloading "purpur engine"
wget -qLO "${ENGINE_PATH}" "https://api.purpurmc.org/v2/purpur/1.20.1/latest/download"
printf "\r${GREEN}:: ${BWHITE}Succesfully downloaded ${BLUE}purpur${BWHITE}!${NC}\n"

function downloadLatestReleases() {
	PLUGIN_NAME=${1//*\//}
	print_downloading "$PLUGIN_NAME"
	curl -s "https://api.github.com/repos/$1/releases/latest" |
		grep browser_download_url |
		cut -d : -f 2,3 |
		tr -d \" |
		wget -O "${PLUGIN_PATH}/${PLUGIN_NAME}.jar" -qLi -
	print_downloaded "$PLUGIN_NAME"
}

function downloadLatestBuild() {
	PLUGIN_NAME="$2"
	PLUGIN_URL="$1"
	print_downloading "$PLUGIN_NAME"
	curl -s "$PLUGIN_URL" |
		grep -Po "$PLUGIN_NAME-.*?\.jar" |
		head -n 1 |
		sed "s#^#${PLUGIN_URL}#" |
		wget -O "${PLUGIN_PATH}/${PLUGIN_NAME}.jar" -qi -
	print_downloaded "$PLUGIN_NAME"
}

function downloadEssentialsX() {
	res=$(curl -s "https://ci-api.essentialsx.net/job/EssentialsX/lastSuccessfulBuild/api/json")
	url=$(echo "$res" | jq '.url' -r)
	path1=$(echo "$res" | jq '.artifacts[0].relativePath' -r) # Get EssentialX
	path2=$(echo "$res" | jq '.artifacts[2].relativePath' -r) # Get EssentialXChat
	print_downloading "EssentialsX"
	wget -qO "${PLUGIN_PATH}/EssentialsX.jar" "${url}artifact/${path1}"
	print_downloaded "EssentialsX"

	print_downloading "EssentialsXChat"
	wget -qO "${PLUGIN_PATH}/EssenstialsXChat.jar" "${url}artifact/${path2}"
	print_downloaded "EssentialsXChat"
}

function downloadLatestFile() {
	PLUGIN_NAME="$2"
	PLUGIN_URL="$1"
	print_downloading "$PLUGIN_NAME"
	wget -qLO "${PLUGIN_PATH}/${PLUGIN_NAME}.jar" "${PLUGIN_URL}"
	print_downloaded "$PLUGIN_NAME"
}

for PLUGIN in "${GITHUB_PLUGINS[@]}"; do
	downloadLatestReleases "$PLUGIN"
done

# Download latest LuckPerms
print_downloading "LuckPerms"
LP_URL=$(curl -s https://metadata.luckperms.net/data/downloads | jq '.downloads.bukkit' -r)
wget -qO "${PLUGIN_PATH}/LuckPerms.jar" "$LP_URL"
print_downloaded "LuckPerms"

# Download EssentialsX and EssentialsXChat
downloadEssentialsX

# Download Chunky
downloadLatestBuild "https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/" "Chunky"

# Download PAPI
downloadLatestBuild "https://ci.extendedclip.com/job/PlaceholderAPI/lastSuccessfulBuild/artifact/build/libs/" "PlaceholderAPI"

for PLUGIN_PAIR in "${FILE_PLUGINS[@]}"; do
	IFS=";"
	read -r PLUGIN_URL PLUGIN_NAME <<<"$PLUGIN_PAIR"
	downloadLatestFile "$PLUGIN_URL" "$PLUGIN_NAME"
done
