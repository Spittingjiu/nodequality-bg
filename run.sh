#!/usr/bin/env bash
set -euo pipefail
INSTALL_DIR="/opt/nodequality-bg"
mkdir -p "$INSTALL_DIR"
curl -fsSL "https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/nodequality-local.sh" -o "$INSTALL_DIR/nodequality-local.sh"
chmod +x "$INSTALL_DIR/nodequality-local.sh"

# default: fast HQ + keep local + remote upload + background
run_out="$({
  env NQ_HQ_MODE="${NQ_HQ_MODE:-f}" \
      NQ_RUN_IQ="${NQ_RUN_IQ:-y}" \
      NQ_RUN_NQ="${NQ_RUN_NQ:-y}" \
      NQ_RUN_BT="${NQ_RUN_BT:-n}" \
      bash "$INSTALL_DIR/nodequality-local.sh" -B "$@"
} 2>&1)"

echo "$run_out"

log_file="$(printf '%s\n' "$run_out" | awk -F= '/^log=/{print $2; exit}')"
if [[ -n "$log_file" && -t 1 ]]; then
  echo
  echo "[nodequality-bg] 正在实时显示测试日志（和原版一样有过程输出）"
  echo "[nodequality-bg] 你随时 Ctrl+C 退出查看；后台测试会继续跑。"
  echo
  tail -f "$log_file" || true
fi
