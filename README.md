# nodequality-bg

在原版 NodeQuality 基础上做的“可远程一键 + 默认后台 + 本地留痕”增强版。  
目标：保留原项目检测能力，同时把实际使用流程变成最省心。

## 原项目
- 原仓库：`https://github.com/LloydAsp/NodeQuality`
- 原一键：`bash <(curl -sL https://run.NodeQuality.com)`
- 检测核心仍依赖原 NodeQuality 生态接口（`Hardware.Check.Place / IP.Check.Place / Net.Check.Place / api.nodequality.com`）。
- 本项目主要做执行体验优化（后台化、默认参数、结果落地、操作简化），不改变原始检测业务语义。

## 这个增强版优化了什么

### 1) 默认后台运行（SSH 断开不影响）

### 2) CPU 测试默认快速模式

### 3) 默认自动上传网页（零参数）

### 4) 上传地址强制落地本地文件

---

## 一键使用（推荐）

直接执行（代码块右上角可一键复制）：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/run.sh)
```

输入一键命令后会出现菜单：
- `1` 运行测试脚本
- `2` 查看最近任务（执行 `tail -f ~/.nodequality-logs/nodequality_*.log`）
- `3` 查看最近一次上传网址（读取 `/root/.nodequality-logs/upload_url.txt`）
- `4` 清除所有痕迹

---

## 最常用查看命令

查看后台日志：
- `ls -lt ~/.nodequality-logs/`
- `tail -f ~/.nodequality-logs/nodequality_*.log`

查看上传地址：
- `cat /root/.nodequality-logs/upload_url.txt`

---

## 可选参数

通过 `--` 透传给底层脚本，例如：

`bash <(curl -fsSL https://raw.githubusercontent.com/Spittingjiu/nodequality-bg/main/run.sh) -- -n`

参数说明：
- `-n`：不上传 NodeQuality 网页（默认上传）
- `-4` / `-6`：强制 IPv4 / IPv6
- `-E`：英文输出
- `-D <dir>`：自定义工作目录基路径

