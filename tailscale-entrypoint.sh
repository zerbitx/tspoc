#!/usr/bin/env bash

# TODO: make this poll tailscale status rather than just sleep for 10 seconds
(sleep 10; tailscale up --authkey `cat /tskey/tailscalekey.unsealed`) &
tailscaled

