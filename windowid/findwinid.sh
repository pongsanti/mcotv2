#!/bin/bash
is_vlc_window_ready() {
  xwininfo -name "VLC media player" | grep "Window id: 0x"
  return $?
}

is_vlc_window_ready
while [ $? -ne 0 ]
do
  echo "Waiting VLC player init..."
  sleep 2
  is_vlc_window_ready
done
echo "VLC player initialized."

xwininfo -name "VLC media player" | grep "Window id: 0x" | sed 's/ /\n/g' | grep 0x > windowid/vlcwindow.id
echo "WIN ID = $(cat windowid/vlcwindow.id)"