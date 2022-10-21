#!/bin/sh

CONFIG_PATH=/usr/local/etc/config
RC_PATH=$CONFIG_PATH/rc.d/

WWW_NAME=www # To prevent typos.
WWW_PATH=$CONFIG_PATH/addons/$WWW_NAME

ADDON_NAME="hm-cf-tunnel"
ADDON_PATH=/usr/local/addons/$ADDON_NAME
ADDON_WWW_PATH=$WWW_PATH/$ADDON_NAME


# Check for /usr/local mounts.
mount | grep /usr/local 2>&1 >/dev/null

if [ $? -eq 1 ];
then
    # A mount for /usr/local exists.
    mount /usr/local # Mount it now.
fi


# Setup required directories.
mkdir -p $ADDON_PATH && chmod 755 $ADDON_PATH
mkdir -p $RC_PATH && chmod 755 $RC_PATH

# Copy files and setup RC script.
cp -af ./$ADDON_NAME/* $ADDON_PATH
cp -f ./$ADDON_NAME.sh $RC_PATH/$ADDON_NAME
chmod +x $RC_PATH/hm-cf-tunnel

# Link web files into www addon directory.
ln -sf $ADDON_PATH/$WWW_NAME $ADDON_WWW_PATH


# Install cloudflared.
cd $ADDON_PATH && ./cfd-install.sh

sync # Persist changes to disk.
exit 0 # No reboot required.
