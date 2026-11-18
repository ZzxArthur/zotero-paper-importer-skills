# Zotero 文献导入与层级归档规范说明

## 1. Zotero 本地接口规范
- **默认监听地址**：`http://127.0.0.1:23119`
- **连通性校验端点**：`GET /connector/ping`，HTTP 200 即代表本地 Zotero 正在运行。
- **元数据导入端点**：`POST /connector/saveItems`
  - 请求头：`Content-Type: application/json`、`X-Zotero-Connector-API-Version: 3`
  - 核心属性包含：`title`, `creators`, `date`, `publicationTitle`, `url`, `abstractNote`, `attachments`。

## 2. 两位数序号命名规范
为了支持在 Zotero 的「标题 (Title)」列中一键按阅读顺序正向排列，所有导入文献必须采用两位数字加英文点与空格作为前缀：
- `01. RT-1: Robotics Transformer for Real-World Control at Scale`
- `02. PaLM-E: An Embodied Multimodal Language Model`
- `03. RT-2: Vision-Language-Action Models Transfer Web Knowledge...`
- `04. RoboFlamingo: Vision-Language Foundation Models...`
- `05. GR-1: Unleashing Large-Scale Video Generative Pre-training...`
- `06. 3D-VLA: A 3D-Centric Embodied Foundation Model`
- `07. Octo: An Open-Source Generalist Robot Policy...`
- `08. OpenVLA: An Open-Source Vision-Language-Action Model`
- `09. π0: A Vision-Language-Action Flow Model for Generalist Robot...`
- `10. CogACT: A Foundational Vision-Language-Action Model...`

## 3. 层级文件夹（Collections）构建树
自动分类时，根据技术流派构建多级目录：
```text
📁 VLA (一级大类)
├── 📁 01_视觉动作基座 (子类)
├── 📁 02_架构解耦与世界模型 (子类)
└── 📁 03_开源通用与高频流匹配 (子类)
```
