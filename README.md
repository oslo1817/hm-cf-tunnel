# Cloudflare Tunnel CCU Addon

A CCU addon providing remote access by the use of a Cloudflare/Argo tunnel. It installs the [Cloudflare Tunnel client (`cloudflared`)][1] and provides a simple
web interface for configuring and managing a single Cloudflare Tunnel.

[1]: https://github.com/cloudflare/cloudflared

## Getting Started

Follow the three simple steps below to install and setup this addon for your CCU
or RaspberryMatic. These steps assume that you have either already created a
Cloudflare Tunnel or that you know how to do so.

> **Note**: This addon requires a (free) Cloudflare Teams account and a working
> outgoing network connection (i.e. port forwarding is not required) to work.

1. Download the latest release from the [releases page][2].

2. Install the addon through the CCU web interface at _Systemsteuerung >
   Zusatzsoftware_ and wait for installation to complete.

3. Configure the addon at `http://<CCU-IP>/addons/hm-cf-tunnel/index.html` or by  
   clicking _Einstellen_ in the _Zusatzsoftware_ web interface.

The `cloudflared` service is started automatically. After setting up the addon,
make sure to visit the [Cloudflare Zero Trust Dashboard][3] and configure the
tunnel's _Public Hostname_ to route traffic through the tunnel to the CCU.

[2]: https://github.com/oskarlorenz/hm-cf-tunnel/releases
[3]: https://dash.teams.cloudflare.com

## Building the Addon

The addon may be build by executing [`scripts/build.sh`](scripts/build.sh). The
archive (`.tar.gz` file) can be found in the [build `output` directory](output).
The following commands demonstrate the invocation (`clean.sh` is optional).

```bash
# Build the addon.
./scripts/build.sh

# Clean build output.
./scripts/clean.sh
```

## Legal Disclaimer

This open source software project is neither affiliated with nor endorsed by
Cloudflare in any way. Cloudflare, the Cloudflare logo, and Cloudflare Tunnel
are trademarks and/or registered trademarks of Cloudflare, Inc. in the United
States and other jurisdictions.

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
