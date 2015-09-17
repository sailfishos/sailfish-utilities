#!/bin/sh

systemctl --user stop tracker-extract.service
systemctl --user stop tracker-miner-fs.service
systemctl --user stop tracker-store.service

tracker-control -krs

systemctl --user start tracker-store.service
systemctl --user start tracker-miner-fs.service
systemctl --user start tracker-extract.service
