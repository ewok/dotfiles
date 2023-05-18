#!/usr/bin/env bash
K_SESSION=$(keyctl request user bw_session)
BW_SESSION=$(keyctl pipe $K_SESSION)
BITWARDENCLI_APPDATA_DIR="$HOME/.config/Bitwarden_CLI_qute" bw "$@"
