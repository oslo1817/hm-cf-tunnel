#!/bin/sh

CFD_ARCHITECTURE=
CFD_VERSION=latest

# Source URLs for the cloudflared executable.
CFD_RELEASES_URL=https://github.com/cloudflare/cloudflared/releases
CFD_LINUX_URL=$CFD_RELEASES_URL/$CFD_VERSION/download/cloudflared-linux


case "$(uname -m)" in

"x86_64")
    CFD_ARCHITECTURE="amd64"
;;

"i386"|"i686")
    CFD_ARCHITECTURE="386"
;;

"aarch64"|"aarch64_be"|"armv8b"|"armv8l")
    CFD_ARCHITECTURE="arm64"
;;

"arm")
    CFD_ARCHITECTURE="arm"
;;

esac


if [ -f "cloudflared" ];

then
    # cloudflared already installed. Run update.
    chmod +x ./cloudflared && ./cloudflared update
    echo "updated $(./cloudflared --version)"

else
    # cloudflared is not installed. Download from GitHub.
    curl -L $CFD_LINUX_URL-$CFD_ARCHITECTURE -o cloudflared
    chmod +x ./cloudflared # Ensure cloudflared is executable.
    echo "installed $(./cloudflared --version)"

fi
