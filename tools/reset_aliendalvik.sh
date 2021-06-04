#!/bin/sh

# Stop aliendalvik if running
if systemctl is-active --quiet aliendalvik
    systemctl stop aliendalvik || :
fi
if systemctl is-active --quiet apkd
    systemctl stop apkd || :
fi

# Remove all launchers
rm -f /usr/share/applications/apkd_launcher_*.desktop
update-desktop-database

if [ -f /opt/alien/system.img ]; then
    # If alien installed, wipe /data, but keep any apps from the store
    if [ -d /home/.android/data/aas-staging/app/packaged ]; then
    # alien8
        mv /home/.android/data/aas-staging/app/packaged /home/.android
        rm -rf /home/.android/data
        mkdir -p /home/.android/data/aas-staging/app/
        mv /home/.android/packaged /home/.android/data/aas-staging/app/
    elif [ -d /home/.android/data/app/packaged ]; then
    # alien4
        systemctl stop alien-settings
        mv /home/.android/data/app/packaged /home/.android
        rm -rf /home/.android/data
        mkdir -p /home/.android/data/app/
        mv /home/.android/packaged /home/.android/data/app/
        /usr/bin/add-oneshot --now alien-create-build-prop
        systemctl-user start alien-pre-start.service
    else
        # neither packaged dir is available, cleanup anyway
        rm -rf /home/.android/data
    fi

    # Start aliendalvik
    systemctl start apkd
    systemctl start aliendalvik
    
    sleep 5
    for apk in /home/.android/data/app/packaged/*.apk; do
        /usr/bin/apkd-harbour-rpm-post $apk
    done
    for apk in /home/.android/data/aas-staging/app/packaged/*.apk; do
        /usr/bin/apkd-harbour-rpm-post $apk
    done
else
    # Just cleanup all data
    rm -rf /home/.android
fi


