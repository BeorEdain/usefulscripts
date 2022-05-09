#! /bin/bash

echo "Importing Linux Surface keys..."
sudo wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg

echo "Adding Linux Surface repository..."

echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main"  sudo tee /etc/apt/sources.list.d/linux-surface.list

echo "Updating system"
sudo apt update

echo "Installing linux-image-surface, linux-headers-surface, iptsd, and libwacom-surface..."
sudo apt install -y linux-image-surface linux-headers-surface iptsd libwacom-surface

echo "Enabling iptsd..."
sudo systemctl enable iptsd

echo "Installing linux-surface-secureboot-mok..."
sudo apt install linux-surface-secureboot-mok

echo "Updating grub..."
sudo update-grub