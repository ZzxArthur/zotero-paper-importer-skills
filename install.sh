#!/usr/bin/env bash
# Zotero Paper Importer Skill - 一键跨平台安装脚本
# 支持 Antigravity / OpenAI Codex / Claude Code / Cursor

set -e

SKILL_NAME="zotero-paper-importer"
REPO_URL="https://github.com/ZzxArthur/zotero-paper-importer-skills.git"

echo "=========================================="
echo "🚀 正在安装 Zotero 文献导入与排序技能: ${SKILL_NAME}"
echo "=========================================="

TMP_DIR=""
if [ -f "SKILL.md" ] && [ -d "scripts" ]; then
    SOURCE_DIR="$(pwd)"
else
    TMP_DIR=$(mktemp -d)
    echo "📦 正在从 GitHub 拉取最新技能文件..."
    git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1
    SOURCE_DIR="$TMP_DIR"
fi

INSTALLED_COUNT=0

# 1. 安装至 Codex (~/.codex/skills)
if [ -d "$HOME/.codex" ] || [ "$1" == "--codex" ] || [ "$1" == "--all" ]; then
    TARGET="$HOME/.codex/skills/${SKILL_NAME}"
    mkdir -p "$TARGET/scripts" "$TARGET/references"
    cp "$SOURCE_DIR/SKILL.md" "$TARGET/"
    cp -r "$SOURCE_DIR/scripts/"* "$TARGET/scripts/" 2>/dev/null || true
    chmod +x "$TARGET/scripts/"*.py 2>/dev/null || true
    cp -r "$SOURCE_DIR/references/"* "$TARGET/references/" 2>/dev/null || true
    echo "✅ [Codex] 已成功安装至: $TARGET"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
fi

# 2. 安装至 Antigravity (~/.gemini/config/skills)
if [ -d "$HOME/.gemini/config" ] || [ "$1" == "--antigravity" ] || [ "$1" == "--all" ]; then
    TARGET="$HOME/.gemini/config/skills/${SKILL_NAME}"
    mkdir -p "$TARGET/scripts" "$TARGET/references"
    cp "$SOURCE_DIR/SKILL.md" "$TARGET/"
    cp -r "$SOURCE_DIR/scripts/"* "$TARGET/scripts/" 2>/dev/null || true
    chmod +x "$TARGET/scripts/"*.py 2>/dev/null || true
    cp -r "$SOURCE_DIR/references/"* "$TARGET/references/" 2>/dev/null || true
    echo "✅ [Antigravity] 已成功安装至: $TARGET"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
fi

# 3. 安装至 Claude Code (~/.claude/skills)
if [ -d "$HOME/.claude" ] || [ "$1" == "--claude" ] || [ "$1" == "--all" ]; then
    TARGET="$HOME/.claude/skills/${SKILL_NAME}"
    mkdir -p "$TARGET/scripts" "$TARGET/references"
    cp "$SOURCE_DIR/SKILL.md" "$TARGET/"
    cp -r "$SOURCE_DIR/scripts/"* "$TARGET/scripts/" 2>/dev/null || true
    chmod +x "$TARGET/scripts/"*.py 2>/dev/null || true
    cp -r "$SOURCE_DIR/references/"* "$TARGET/references/" 2>/dev/null || true
    echo "✅ [Claude Code] 已成功安装至: $TARGET"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
fi

# 4. 当前工作区 Cursor 规则
if [ -f ".cursorrules" ] || [ -d ".cursor" ]; then
    cp "$SOURCE_DIR/adapters/.cursorrules" ./.cursorrules 2>/dev/null || true
    echo "✅ [Cursor] 已将规则配置至当前工作区: ./.cursorrules"
fi

if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
fi

echo "=========================================="
if [ $INSTALLED_COUNT -gt 0 ]; then
    echo "🎉 安装完成！在对话中直接输入「导入到 Zotero」即可触发。"
else
    echo "⚠️ 可使用 --all 参数强制安装到所有支持的环境："
    echo "   ./install.sh --all"
fi
echo "=========================================="
