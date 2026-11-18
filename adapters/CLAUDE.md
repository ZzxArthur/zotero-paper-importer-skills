# Zotero Paper Importer - Claude Code Instructions
# 放置于项目根目录 CLAUDE.md 或 .claude/skills/zotero-importer.md

## Zotero Batch Literature Importer Workflow

1. **Client & Version Detection**:
   - Check local Zotero connection at `http://127.0.0.1:23119/connector/ping`.
   - Prompt the user with the detected Zotero client version and remind them to keep Zotero running.
2. **Unified Single Inquiry**:
   - Combine destination collection preference and reading order confirmation into ONE single message.
3. **Hierarchical Collections**:
   - Automatically create parent collections (e.g. `VLA`) and sub-collections (e.g. `01_Foundation`, `02_OpenSource`) when auto-mode is selected.
4. **Title Numbering**:
   - Prefix paper titles strictly with two-digit rank `01. `, `02. `, `03. ` for easy ascending sorting in Zotero.
5. **Metadata & Attachments**:
   - Extract and inject complete metadata, and link or download PDF full text.
