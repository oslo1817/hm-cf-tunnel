#!/bin/sh

ADDON_TITLE="Cloudflare Tunnel"
ADDON_DESCRIPTION="Cloudflare Tunnel CCU Addon"

ADDON_NAME=hm-cf-tunnel
ADDON_PATH=/usr/local/addons/$ADDON_NAME
ADDON_VERSION=$(cat $ADDON_PATH/VERSION)
ADDON_WWW_URL=/addons/$ADDON_NAME

CFD_PATH=$ADDON_PATH/cloudflared

# Parse cloudflared version without build time.
CFD_VERSION=$($CFD_PATH --version | sed "s: (.*::g")


case "$1" in

info)
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
