#!/bin/sh
set -eu

: "${LISTEN_PORT:=51820}"
: "${UPSTREAM_HOST:?Set UPSTREAM_HOST to the WireGuard server DDNS hostname}"
: "${UPSTREAM_PORT:=51820}"
: "${DNS_RESOLVER:=1.1.1.1}"

export LISTEN_PORT UPSTREAM_HOST UPSTREAM_PORT DNS_RESOLVER
envsubst '${LISTEN_PORT} ${UPSTREAM_HOST} ${UPSTREAM_PORT} ${DNS_RESOLVER}' \
	< /etc/nginx/nginx.conf.template \
	> /tmp/nginx.conf

nginx -t -c /tmp/nginx.conf
exec nginx -c /tmp/nginx.conf -g 'daemon off;'
