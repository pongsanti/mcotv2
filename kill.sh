#!/bin/bash
vlc/kill_vlc.sh
kill $(cat first.pid)

rm vlc/vlc.pid
rm windowid/vlcwindow.id
