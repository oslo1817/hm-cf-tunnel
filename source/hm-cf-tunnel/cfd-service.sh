#!/bin/sh

ADDON_PATH=/usr/local/addons/hm-cf-tunnel
CFD_PATH=$ADDON_PATH/cloudflared

INIT_PATH=/etc/init.d
CFD_INIT_PATH=$INIT_PATH/cloudflared


case "$1" in

install)
    if [ -f $CFD_INIT_PATH ]; then
        # The cloudflared service file is already installed. Can't proceed.
        echo "the cloudflared service file is already installed" >&2; exit 1
    else
        # The cloudflared service file is not installed. Install now.
        echo "installing cloudflared service ..."; echo

        shift # Remove first argument.
        $CFD_PATH service install "$@"

        if [ -f $CFD_INIT_PATH ]; then
            # The cloudflared service file was installed. Apply patches.

            echo "patching cloudflared service file ..."
            patch -p0 < $ADDON_PATH/cfd-service.patch
        fi
    fi
;;

start|stop|restart)
    if [ -f $CFD_INIT_PATH ]; then
        # Delegate to cloudflared service.
        cd $INIT_PATH && $CFD_INIT_PATH "$1"
    else
        # The cloudflared service file does not exit.
        echo "the cloudflared service file is not installed"; exit 1
    fi
;;

status)
    if [ -f $CFD_INIT_PATH ]; then
        # Delegate to cloudflared service.
        cd $INIT_PATH && $CFD_INIT_PATH status
    else
        # The cloudflared service file does not exit.
        echo "Stopped (no tunnel)"; exit 1
    fi
;;

uninstall)
    if [ -f $CFD_INIT_PATH ]; then
        # The cloudflared service file is installed. Stop and remove it.
        echo "uninstalling cloudflared service ..."; echo

        if $0 stop; then
            echo "deleting service files ..."; rm -f $CFD_INIT_PATH
        fi
    else
        # The cloudflared service file is not installed. Nothing to do.
        echo "the cloudflared service file is not installed" >&2; exit 1
    fi
;;

esac