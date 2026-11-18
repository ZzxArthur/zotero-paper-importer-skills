#!/usr/bin/env python3
"""
Zotero Batch Paper Importer Script
用于将结构化学术文献列表批量导入本地运行中的 Zotero。
"""

import json
import sys
import urllib.request
import urllib.error
import subprocess
import os

ZOTERO_CONNECTOR_URL = "http://127.0.0.1:23119"

def check_zotero_status():
    """检测 Zotero 运行状态与版本"""
    # 1. 检测本地 Connector 端口
    is_running = False
    try:
        req = urllib.request.Request(f"{ZOTERO_CONNECTOR_URL}/connector/ping")
        with urllib.request.urlopen(req, timeout=1.5) as resp:
            if resp.status == 200:
                is_running = True
    except Exception:
        pass

    # 2. 检测版本信息
    version_str = "未知版本"
    app_ini = "/home/hatepp/.local/opt/zotero/Zotero_linux-x86_64/app/application.ini"
    if os.path.exists(app_ini):
        try:
            with open(app_ini, "r", encoding="utf-8") as f:
                for line in f:
                    if line.startswith("Version="):
                        version_str = line.strip().split("=")[1]
                        break
        except Exception:
            pass

    return is_running, version_str

def get_current_collections():
    """获取当前 Zotero 中的 Collections 结构"""
    try:
        req = urllib.request.Request(
            f"{ZOTERO_CONNECTOR_URL}/connector/getSelectedCollection",
            data=b"{}",
            headers={"Content-Type": "application/json"}
        )
        with urllib.request.urlopen(req, timeout=2.0) as resp:
            data = json.loads(resp.read().decode("utf-8"))
            return data.get("targets", [])
    except Exception as e:
        return []

def import_paper_item(item_data, session_id="zotero-import-session"):
    """
    通过 Zotero Connector API 导入单个文献条目
    item_data 结构包含:
      title: 带 "01. " 序号的标题
      creators: [{"creatorType": "author", "firstName": "...", "lastName": "..."}]
      date: 年份或日期
      publicationTitle: 会议/期刊名
      url: 原文链接
      abstractNote: 摘要
      pdf_url: PDF 下载直链
    """
    payload_item = {
        "itemType": "journalArticle",
        "title": item_data.get("title", "Untitled"),
        "creators": item_data.get("creators", []),
        "date": str(item_data.get("date", "")),
        "publicationTitle": item_data.get("publicationTitle", ""),
        "url": item_data.get("url", ""),
        "abstractNote": item_data.get("abstractNote", "")
    }

    attachments = []
    if item_data.get("pdf_url"):
        attachments.append({
            "title": "Full Text PDF",
            "url": item_data["pdf_url"],
            "mimeType": "application/pdf"
        })
    if attachments:
        payload_item["attachments"] = attachments

    body = {
        "items": [payload_item],
        "uri": item_data.get("url", "https://arxiv.org"),
        "sessionID": session_id
    }

    req = urllib.request.Request(
        f"{ZOTERO_CONNECTOR_URL}/connector/saveItems",
        data=json.dumps(body).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "X-Zotero-Connector-API-Version": "3"
        }
    )

    try:
        with urllib.request.urlopen(req, timeout=5.0) as resp:
            return True, "成功"
    except urllib.error.HTTPError as e:
        return False, f"HTTP Error {e.code}: {e.read().decode('utf-8')}"
    except Exception as e:
        return False, str(e)

if __name__ == "__main__":
    running, ver = check_zotero_status()
    print(f"Zotero 运行状态: {'🟢 正在运行' if running else '🔴 未启动'}")
    print(f"Zotero 客户端版本: {ver}")
    if not running:
        sys.exit(1)
    
    cols = get_current_collections()
    print(f"已识别现有集合 (Collections): {len(cols)} 个")
