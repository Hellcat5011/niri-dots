#!/bin/bash

current=$(qs -c noctalia-shell ipc call wallpaper get "all")


choose() {

  local choice=$1

  if [[ $choice == [yY]* ]]; then
    {
      sudo cp -f "$current" '/usr/share/sddm/themes/sugar-candy/Backgrounds/default'
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
