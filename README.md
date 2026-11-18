# Zotero Paper Importer Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Ready-brightgreen.svg)](#)
[![Zotero](https://img.shields.io/badge/Zotero-7%20%2F%2010%2B-red.svg)](https://www.zotero.org/)
[![Multi-Platform](https://img.shields.io/badge/Platform-Codex%20%7C%20Antigravity%20%7C%20Cursor%20%7C%20Claude-orange.svg)](#)

> **专为科研学者打造的 Zotero 文献批量导入与层级归档工作流**：支持客户端版本先验检测、单次合并偏好确认、父子层级分类树建立，以及 `01. `, `02. ` 两位数阅读序号标题排序。

---

## ⚡ 一键极速安装 (Quick One-Liner)

在终端执行以下一行命令，将**自动检测本机已安装的 AI Agent 环境（Codex / Antigravity / Claude Code）并自动挂载技能**：

```bash
curl -fsSL https://raw.githubusercontent.com/ZzxArthur/zotero-paper-importer-skills/main/install.sh | bash
```

---

## 🌟 核心功能与设计亮点

1. **客户端与版本自动检测**：执行前自动核验本地 Zotero 运行状态及客户端版本（支持 Zotero 7 / 10+），提示用户保持客户端在后台运行。
2. **单次合并澄清机制**：如果用户未指定存放目录或排序规则，**只在单条消息中同时询问目标分类与排序偏好**，拒绝多步冗长交互。
3. **树状层级分类目录（Collections）**：支持自动识别技术路线建立多级父子文件夹（例如：父文件夹 `VLA` $\to$ 子文件夹 `01_视觉动作基座`、`02_开源通用底座`）。
4. **`01. `, `02. ` 两位数阅读序号排序**：在论文标题前自动注入推荐阅读顺位的两位数编号，导入后用户在 Zotero 中**点击标题列即可一键按知识梯度正向排列**。
5. **元数据与全文 PDF 自动关联合成**：抓取完整的发表信息、会议期刊、摘要，并自动挂载开放获取的 PDF 全文附件。

---

## 📋 仓库文件结构

```text
zotero-paper-importer-skills/
├── SKILL.md                  # 核心技能规范
├── install.sh                # 跨平台一键安装脚本
├── scripts/
│   └── zotero_import.py      # 本地 Zotero 通信与批量导入 Python 脚本
├── references/
│   └── ZOTERO_WORKFLOW_SPEC.md # 接口协议与层级归纳标准
├── adapters/                 # 跨平台开箱即用规则
│   ├── .cursorrules          # Cursor 适配规则
│   ├── CLAUDE.md             # Claude Code 适配规则
│   └── system_prompt.txt     # 通用 Web 模型提示词
├── examples/
│   └── vla_import_demo.md    # 具身智能 VLA 10 篇精选导入案例效果
├── README.md
└── LICENSE
```

---

## 🚀 跨平台使用指引

### 1. OpenAI Codex 用户
- **一键极速安装**：
  ```bash
  curl -fsSL https://raw.githubusercontent.com/ZzxArthur/zotero-paper-importer-skills/main/install.sh | bash -s -- --codex
  ```
- 安装后，在 Codex 对话中输入类似：“*帮我把刚才的文献列表导入 Zotero*”即可触发。

### 2. Antigravity 用户
运行一键安装脚本，或手动复制到全局配置目录：
```bash
cp -r . ~/.gemini/config/skills/zotero-paper-importer
```

### 3. Cursor 用户
将 `adapters/.cursorrules` 复制到项目根目录即可生效。

### 4. Claude Code 用户
将 `adapters/CLAUDE.md` 放入项目根目录或全局 `~/.claude/skills/` 中。

---

## 💡 效果演示（以具身智能 VLA 10 篇为例）

```text
📁 我的文库 (My Library)
└── 📁 VLA (大类目录)
    ├── 📁 01_视觉语言动作基座 (子目录)
    │   ├── 01. RT-1: Robotics Transformer for Real-World Control at Scale (+ PDF)
    │   ├── 02. PaLM-E: An Embodied Multimodal Language Model (+ PDF)
    │   └── 03. RT-2: Vision-Language-Action Models Transfer Web Knowledge... (+ PDF)
    ├── 📁 02_架构解耦与世界模型 (子目录)
    │   ├── 04. RoboFlamingo: Vision-Language Foundation Models... (+ PDF)
    │   ├── 05. GR-1: Unleashing Large-Scale Video Generative Pre-training... (+ PDF)
    │   └── 06. 3D-VLA: A 3D-Centric Embodied Foundation Model (+ PDF)
    └── 📁 03_开源通用与高频流匹配 (子目录)
        ├── 07. Octo: An Open-Source Generalist Robot Policy... (+ PDF)
        ├── 08. OpenVLA: An Open-Source Vision-Language-Action Model (+ PDF)
        ├── 09. π0: A Vision-Language-Action Flow Model for Generalist Robot... (+ PDF)
        └── 10. CogACT: A Foundational Vision-Language-Action Model... (+ PDF)
```

---

## 📄 开源许可证

本项目基于 MIT 许可证开源。
