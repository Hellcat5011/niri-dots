#!/bin/bash

sudo pacman -S git base-devel --needed

#paru
if [[ ! -d "paru" ]]; then
git clone https://aur.archlinux.org/paru.git
fi

cd paru
makepkg -si

cd ..

paru -S --needed $(cat ./progs.txt)

mkdir -p "$HOME/.config"

cp -R ./configs/* $HOME/.config/

swaybg -i $HOME/.config/niri/user/scripts/.wallpaper_current &
disown

matugen image $HOME/.config/niri/user/scripts/.wallpaper_current -m "dark" -t "scheme-tonal-spot"  --source-color-index "0"

sudo cp ./sddm.conf /etc/sddm.conf

sleep 2

mkdir -p $HOME/.local/share/fonts
cp ./FastHand-lgBMV.ttf $HOME/.local/share/fonts/
fc-cache -f -v

sudo systemctl enable sddm
sudo systemctl enable NetworkManager
sudo systemctl enable blueman

echo "Install complete, please reboot your system"
read -p "Press enter to exit ..."
