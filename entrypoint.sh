#!/bin/bash

curl -o /home/runner/.config/clash/config.yaml "$SUB_URL"

# 允许局域网链接
sed -i 's/allow-lan: false/allow-lan: true/g' /home/runner/.config/clash/config.yaml

exec /usr/local/bin/entrypoint.sh "$@"