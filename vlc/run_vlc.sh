#!/bin/bash
DISPLAY=:0 cvlc -f --meta-title mcot http://localhost:9981/play/stream/service/8d3204cd1011c35eca0bacec61b498de?title=MCOT%20HD%20%2F%20MCOT &
echo $! > vlc/vlc.pid
