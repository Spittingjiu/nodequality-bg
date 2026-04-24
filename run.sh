#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="/opt/nodequality-bg"
LOG_DIR="/root/.nodequality-logs"
UPLOAD_TXT="/root/.nodequality-logs/upload_url.txt"

install_main_script() {
  mkdir -p "$INSTALL_DIR"
  curl -fsSL "https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/nodequality-local.sh" -o "$INSTALL_DIR/nodequality-local.sh"
  chmod +x "$INSTALL_DIR/nodequality-local.sh"
}

run_test() {
  local run_out log_file
  run_out="$({
    env NQ_HQ_MODE="${NQ_HQ_MODE:-f}" \
        NQ_RUN_IQ="${NQ_RUN_IQ:-y}" \
        NQ_RUN_NQ="${NQ_RUN_NQ:-y}" \
        NQ_RUN_BT="${NQ_RUN_BT:-n}" \
        bash "$INSTALL_DIR/nodequality-local.sh" -B
  } 2>&1)"

  echo "$run_out"

  log_file="$(printf '%s\n' "$run_out" | awk -F= '/^log=/{print $2; exit}')"
  if [[ -n "$log_file" && -t 1 ]]; then
    echo
    echo "[nodequality-bg] 正在实时显示测试日志（Ctrl+C 仅退出查看，后台任务继续）"
    echo
    tail -f "$log_file" || true
  fi
}

view_recent_task() {
  mkdir -p "$LOG_DIR"
  echo "执行: tail -f ~/.nodequality-logs/nodequality_*.log"
  tail -f ~/.nodequality-logs/nodequality_*.log
}

view_upload_url() {
  if [[ -f "$UPLOAD_TXT" ]]; then
    cat "$UPLOAD_TXT"
  else
    echo "未找到上传记录：$UPLOAD_TXT"
  fi
}

clear_all_traces() {
  rm -f "$UPLOAD_TXT"
  rm -f /root/nodequality_upload_url.txt
  rm -rf "$LOG_DIR"
  rm -rf /root/.nodequality*
  rm -rf "$INSTALL_DIR"
  echo "已清除 nodequality-bg 相关痕迹。"
}

show_menu() {
  cat <<'EOF'
========== nodequality-bg ==========
1) 运行测试脚本
2) 查看最近的任务日志
3) 查看最近一次上传网址
4) 清除所有痕迹
====================================
EOF
}

main() {
  install_main_script

  if [[ ! -t 0 ]]; then
    run_test
    exit 0
  fi

  show_menu
  read -rp "请选择 [1-4]: " choice
  case "$choice" in
    1) run_test ;;
    2) view_recent_task ;;
    3) view_upload_url ;;
    4) clear_all_traces ;;
    *) echo "无效选项"; exit 1 ;;
  esac
}

main "$@"
