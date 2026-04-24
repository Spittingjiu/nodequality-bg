#!/usr/bin/env bash
set -euo pipefail
INSTALL_DIR="/opt/nodequality-bg"
mkdir -p "$INSTALL_DIR"
curl -fsSL "https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/nodequality-local.sh" -o "$INSTALL_DIR/nodequality-local.sh"
chmod +x "$INSTALL_DIR/nodequality-local.sh"

# default: fast HQ + keep local + no remote upload + background
env NQ_HQ_MODE="${NQ_HQ_MODE:-f}" \
    NQ_RUN_IQ="${NQ_RUN_IQ:-y}" \
    NQ_RUN_NQ="${NQ_RUN_NQ:-y}" \
    NQ_RUN_BT="${NQ_RUN_BT:-n}" \
    bash "$INSTALL_DIR/nodequality-local.sh" -B "$@"
