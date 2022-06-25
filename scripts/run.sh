#!/usr/bin/bash
ENGINE_PATH="$(dirname "$0")/../src/purpur.jar"
cd "$(dirname "$0")/../src/"
java -Xmx4096M -Xms4096M --add-modules=jdk.incubator.vector -jar purpur.jar nogui
