#!/bin/bash

choose() {

  local choice=$1

  if [[ $choice == [yY]* ]]; then
    {
      sudo cp -f '/home/vic/.config/niri/user/scripts/.wallpaper_current' '/usr/share/sddm/themes/sugar-candy/Backgrounds/default'
      echo "Done! Press enter to exit"
      read
    }
  else
    echo -e "sddm wallpaper not updated \n Press enter to exit"
    read
  fi

}

main() {

  echo "Would you like to update the sddm wallpaper?"
  read chs

  choose "$chs"
}

main
