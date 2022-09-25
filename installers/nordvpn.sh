#!/bin/bash -e

if command -v curl &> /dev/null; then
    echo "Downloading NordVPN installer..."

else
	echo "curl is not installed, installing now..."
	sudo apt install -y curl
	echo "Installing NordVPN..."
    
fi

sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

sudo usermod -aG nordvpn $USER

echo "Please reboot your system to allow $USER to use NordVPN without sudo powers."