#!/usr/bin/env sh

echo "\e[36m  - Installing Heroic Launcher...\e[0m"
curl -o /tmp/heroic.deb  https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.20.1/Heroic-2.20.1-linux-amd64.deb
sudo dkpg -i /tmp/heroic.deb