# WireGuard IPv4-to-IPv6 UDP relay

A small Nginx Stream container that accepts WireGuard UDP packets over IPv4
and relays them to a WireGuard server resolved over IPv6.

## Build and run

```sh
podman build -t wg-proxy .

podman run --rm --name wg-proxy \
  -p 51820:51820/udp \
  -e UPSTREAM_HOST=wg.example.net \
  -e UPSTREAM_PORT=51820 \
  wg-proxy
```

Set the WireGuard client's `Endpoint` to the relay's IPv4 address and exposed
UDP port.

## Configuration

| Variable | Default | Meaning |
| --- | --- | --- |
| `LISTEN_PORT` | `51820` | IPv4 UDP port exposed by the relay |
| `UPSTREAM_HOST` | required | WireGuard server's hostname (can be DDNS resolving to AAAA) |
| `UPSTREAM_PORT` | `51820` | WireGuard server's UDP port |
| `DNS_RESOLVER` | `1.1.1.1` | DNS resolver address; Cloudflare by default |

The hostname is resolved dynamically for new UDP sessions. An active session
can remain bound to the previous IPv6 address after a DDNS update.

The relay only forwards to the configured upstream; it is not an open UDP
proxy. WireGuard sees the relay's IPv6 address as the peer's network endpoint,
while WireGuard authentication remains end-to-end.
