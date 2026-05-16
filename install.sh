#!/bin/bash

sudo pacman -S git base-devel --needed

dir=$(pwd)

#paru
if ! pacman -Qs paru > dev/null; then
mkdir $HOME/paru
git clone https://aur.archlinux.org/paru.git $HOME/paru
cd $HOME/paru
makepkg -si

cd $dir

fi

paru -S --needed $(cat ./progs.txt)

mkdir -p "$HOME/.config" "$HOME/.cache"

cp -R ./configs/* $HOME/.config/

cp -R ./wal $HOME/.cache/wal

sudo cp ./sddm.conf /etc/sddm.conf

sleep 2

mkdir -p $HOME/.local/share/fonts
cp -r ./fonts/* $HOME/.local/share/fonts/
fc-cache -f -v

echo "Installing Nvidia drivers"
sudo pacman -S linux-headers nvidia-dkms nvidia-utils nvidia-settings

sudo sed -i "s/^MODULES=(.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" "/etc/mkinitcipo.conf"

sudo mkinitcpio -P

sudo cp ./environment /etc/environment
sudo cp ./nvidia.conf /etc/modprobe.d/nvidia.conf

sudo systemctl enable sddm
sudo systemctl enable NetworkManager

echo "Install complete, please reboot your system"
read -p "Press enter to exit ..."
