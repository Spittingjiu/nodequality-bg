# nodequality-bg

在原版 NodeQuality 基础上做的“可远程一键 + 默认后台 + 本地留痕”增强版。  
目标：保留原项目检测能力，同时把实际使用流程变成最省心。

## 原项目
- 原仓库：`https://github.com/LloydAsp/NodeQuality`
- 原一键：`bash <(curl -sL https://run.NodeQuality.com)`

## 这个增强版优化了什么

### 1) 默认后台运行（SSH 断开不影响）
- 原版前台跑，断连容易中断
- 增强版默认 `nohup` 后台跑，适合 VPS 远程执行

### 2) CPU 测试默认快速模式
- 默认 `NQ_HQ_MODE=f`
- 相比原版默认深度硬件测，耗时明显更可控

### 3) 默认自动上传网页（零参数）
- 现在直接一键就会上传 NodeQuality 网页
- 不需要再手动加 `-u`

### 4) 上传地址强制落地本地文件
- 每次上传后都会写入：`/root/nodequality_upload_url.txt`
- 文件中包含：
  - `upload_api=...`
  - `upload_url=...`（若接口返回链接）
  - `upload_response=...`
  - `updated_at=...`

### 5) 本地结果也保留（不打包 zip）
- 同步保留本地原始结果文件，便于直接查看
- 输出目录包含：
  - `raw_时间戳/`（原始结果文件目录）
  - `summary_时间戳.txt`

---

## 一键使用（推荐）

直接执行：

`bash <(curl -fsSL https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/run.sh)`

默认行为：
- 后台运行
- 自动上传网页
- 自动写 `/root/nodequality_upload_url.txt`
- 同时保留本地原始结果目录（不打包）

---

## 最常用查看命令

查看后台日志：
- `ls -lt ~/.nodequality-logs/`
- `tail -f ~/.nodequality-logs/nodequality_*.log`

查看上传地址：
- `cat /root/nodequality_upload_url.txt`

---

## 可选参数

通过 `--` 透传给底层脚本，例如：

`bash <(curl -fsSL https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/run.sh) -- -n`

参数说明：
- `-n`：不上传 NodeQuality 网页（默认上传）
- `-4` / `-6`：强制 IPv4 / IPv6
- `-E`：英文输出
- `-D <dir>`：自定义工作目录基路径

---

## 可选环境变量

- `NQ_HQ_MODE=f|y|v|n`（默认 `f`，快速硬件测试）
- `NQ_RUN_IQ=y|n`（默认 `y`）
- `NQ_RUN_NQ=y|l|n`（默认 `y`）
- `NQ_RUN_BT=y|n`（默认 `n`）

示例：

`NQ_HQ_MODE=v bash <(curl -fsSL https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/run.sh)`

---

## 目录与文件说明

- 在线入口脚本：`run.sh`
- 增强主脚本：`nodequality-local.sh`
- 远端安装目录：`/opt/nodequality-bg/`
- 固定上传信息文件：`/root/nodequality_upload_url.txt`
- 后台日志目录：`~/.nodequality-logs/`

---

## 声明

- 检测核心仍依赖原 NodeQuality 生态接口（`Hardware.Check.Place / IP.Check.Place / Net.Check.Place / api.nodequality.com`）。
- 本项目主要做执行体验优化（后台化、默认参数、结果落地、操作简化），不改变原始检测业务语义。