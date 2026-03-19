#!/bin/bash

step=10

get_brightness() {
  ddcutil --bus 7 getvcp 10 --terse | awk '{print$4}'
}

change_brightness() {
  local input=$1
  local current new

  current=$(get_brightness)
  new=$((current + input))

  ((new < 5)) && new=5
  ((new > 100)) && new=100

  ddcutil --bus 7 setvcp 10 $new
  echo $new > /mnt/hdd/.wobpipe
}

case "$1" in
"--inc")
  change_brightness "$step"
  ;;
"--dec")
  change_brightness "-$step"
  ;;
*)
  get_brightness
  ;;
esac
