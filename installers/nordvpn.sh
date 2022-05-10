#!/bin/bash -e

if command -v curl &> /dev/null; then
    echo "Downloading NordVPN installer with curl"
    sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

elif command -v wget &> /dev/null; then
    echo "Downloading NordVPN installer with wget"
     sh <(wget -qO https://downloads.nordcdn.com/apps/linux/install.sh)

else
    echo "Neither curl nor wget exists on this system. Please install either one and rerun this script."
    
fi

nordvpn connect