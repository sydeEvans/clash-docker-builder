#!/bin/bash

curl -o /home/runner/.config/clash/clash.yaml "$SUB_URL"

exec /usr/local/bin/entrypoint.sh "$@"