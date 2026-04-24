# nodequality-bg

一键后台运行 NodeQuality（默认本地保存结果，不上传网页）。

## 一键命令
bash <(curl -fsSL https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/run.sh)

## 查看日志
ls -lt ~/.nodequality-logs/
tail -f ~/.nodequality-logs/nodequality_*.log

## 结果位置
测试完成后结果打包在：
- `.../results/result_时间戳.zip`
- `.../results/summary_时间戳.txt`

## 可选参数
- `-u`：上传结果到 NodeQuality 网页（默认不上传）
- `-4` / `-6`：强制 IPv4/IPv6
- `-E`：英文输出

## 环境变量（可选）
- `NQ_HQ_MODE=f|y|v|n`（默认 `f`，CPU 快速模式）
- `NQ_RUN_IQ=y|n`（默认 `y`）
- `NQ_RUN_NQ=y|l|n`（默认 `y`）
- `NQ_RUN_BT=y|n`（默认 `n`）
