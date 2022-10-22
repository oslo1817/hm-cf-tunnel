#!/bin/sh

CONFIG_PATH=/usr/local/etc/config
RC_PATH=$CONFIG_PATH/rc.d/

WWW_NAME=www # To prevent typos.
WWW_PATH=$CONFIG_PATH/addons/$WWW_NAME

ADDON_NAME="hm-cf-tunnel"
ADDON_DESCRIPTION="Cloudflare Tunnel CCU Addon"
ADDON_TITLE="Cloudflare Tunnel"

ADDON_PATH=/usr/local/addons/$ADDON_NAME
ADDON_WWW_PATH=$WWW_PATH/$ADDON_NAME
ADDON_WWW_URL=/addons/$ADDON_NAME

CFD_PATH=$ADDON_PATH/cloudflared


case "$1" in

install)
    if [ -f update_script ]; then
        # Check for /usr/local mounts.
        mount | grep /usr/local 2>&1 >/dev/null

        if [ $? -eq 1 ]; then
            # A mount for /usr/local exists.
            mount /usr/local # Mount it now.
        fi

        # Setup required directories.
        mkdir -p $ADDON_PATH && chmod 755 $ADDON_PATH
        mkdir -p $RC_PATH && chmod 755 $RC_PATH

        rm -rf $ADDON_PATH/* # Clean addon directory.

        # Copy files and setup RC script.
        cp -af ./$ADDON_NAME/* $ADDON_PATH
        cp -f ./$ADDON_NAME.sh $RC_PATH/$ADDON_NAME
        chmod +x $RC_PATH/$ADDON_NAME

        # Link web files into www addon directory.
        ln -sf $ADDON_PATH/$WWW_NAME $ADDON_WWW_PATH

        # Install cloudflared executable.
        cd $ADDON_PATH && ./cfd-install.sh

        sync # Persist changes to disk.
        exit 0 # No reboot required.
    else
        # Prevent installs after the actual install.
        echo "install requires update_script" >&2; exit 1
    fi
;;

info)
    ADDON_VERSION=$(cat $ADDON_PATH/VERSION)

    # Parse cloudflared version without build time.
    CFD_VERSION=$($CFD_PATH --version | sed 's: (.*::g')

    echo "Name: $ADDON_TITLE"
    echo "Version: $ADDON_VERSION"

    echo "Info: <b>$ADDON_DESCRIPTION</b><br>"
    echo "Info: Copyright (c) 2022 Oskar Lorenz"
    echo "Info: ($CFD_VERSION)"

    echo "Update: $ADDON_WWW_URL/update.cgi"
    echo "Operations: uninstall restart"
;;

start)
    echo "not implemented"
;;

restart)
    echo "not implemented"
;;

uninstall)
    echo "not implemented"
;;

esac
