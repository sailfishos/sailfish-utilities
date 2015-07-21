#!/bin/sh
nohup sh -c "pkill jolla-settings;systemctl --user --no-block restart lipstick.service" 1>/dev/null 2>/dev/null &

