#!/bin/bash
vlc/kill_vlc.sh
kill -9 $(cat first.pid)
kill -9 $(cat second.pid)

rm vlc/vlc.pid
rm windowid/vlcwindow.id
