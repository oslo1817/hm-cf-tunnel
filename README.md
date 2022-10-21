# Cloudflare Tunnel CCU Addon

A CCU addon providing remote access by the use of a Cloudflare/Argo tunnel.

## Usage

At the current state of development this addon merely installs the required
[`cloudflared`](https://github.com/cloudflare/cloudflared) executable, but does
not provide any functionality on top. Actually using `cloudflared` with this
addon requires an SSH connection for manual setup of Cloudflare tunnels.

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
