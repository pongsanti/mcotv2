#!/bin/bash
vlc/run_vlc.sh
sleep 8 # wait window to open
windowid/findwinid.sh
ruby first.rb &
echo $! > first.pid
ruby second.rb &
echo $! > second.pid
