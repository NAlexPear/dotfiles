#!/bin/bash

elapsed="0"
cache=""

while [[ $(ps -u $USER | grep spotify) ]]; do
  title=`exec playerctl metadata xesam:title`
  artist=`exec playerctl metadata xesam:artist`
  album=`exec playerctl metadata xesam:album`
  length=`exec playerctl metadata mpris:length`

  secs=$(($length/1000000))
  timestamp=`printf ""%d:%02d"" $(($secs%3600/60)) $(($secs%60))`


  function update_cache {
    if [ "$cache" != "$artist $title $album $length" ]; then
      cache="$artist $title $album $length"
      elapsed="0"
    fi
  }

  function get_info {
    position=`printf ""%d:%02d"" $(($elapsed%3600/60)) $(($elapsed%60))`

    echo "$title <span style=\"italic\">by</span> $artist $album  $position $timestamp"
  }

  if [ "$(playerctl status)" = "Playing" ]; then
    elapsed=$(($elapsed + 1))
    update_cache

    echo "⏸ $(get_info)"
  else
    echo "▶ $(get_info)"
  fi

  sleep 1
done

echo ""
