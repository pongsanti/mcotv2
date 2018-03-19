#!/bin/bash
vlc/kill_vlc.sh
kill $(cat first.pid)
kill $(cat second.pid)

rm vlc/vlc.pid
rm windowid/vlcwindow.id
