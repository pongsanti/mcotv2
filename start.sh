#!/bin/bash
vlc/run_vlc.sh
windowid/findwinid.sh
ruby first.rb &
echo $! > first.pid
ruby second.rb &
echo $! > second.pid
