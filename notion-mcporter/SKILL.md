---
name: notion-mcporter
description: Record research notes to Notion using the Notion MCP server via mcporter. Use when you need to append research findings to an existing Notion page or create new research pages programmatically. Trigger this skill when the user provides a Notion page ID and wants to add structured research notes, summaries, or findings to their Notion workspace.
---

# Notion-MCPorter Skill

Record research notes to Notion using the Notion MCP server via mcporter. Use when you need to append research findings to an existing Notion page or create new research pages programmatically. Trigger this skill when the user provides a Notion page ID and wants to add structured research notes, summaries, or findings to their Notion workspace.

## Setup

Verify the Notion MCP server is available:
```bash
mcporter list notion
```

## Usage

### Append Research Note to Existing Page

Add a paragraph block with your research content to a Notion page:
```bash
mcporter call notion.API-patch-block-children --args '{"block_id": "YOUR_PAGE_ID", "children": [{"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "Your research note here"}}]}]}'
```

### Create New Research Page

Create a new page under a parent page or database:
```bash
mcporter call notion.API-post-page --args '{"parent": {"type": "page_id", "page_id": "YOUR_PARENT_PAGE_ID"}, "properties": {"title": [{"type": "text", "text": {"content": "Research Topic"}}]}, "children": [{"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "Initial research note"}}]}]}'
```

## Workflow

1. **Get Page ID**: Open your target Notion page, click Share → Copy link, extract the ID from the URL (it's the 32-character string after the last slash)
2. **Add Notes**: Use the append command above for each research note or summary
3. **Repeat**: Continue adding notes as your research progresses

## Format Notes

- Replace `YOUR_PAGE_ID` with your actual Notion page ID
- For database parents, use `{"type":"database_id","database_id":"YOUR_DB_ID"}`
- Content supports Notion rich text formatting (bold, italic, links, etc.) within the text.content field
- Notion API version is handled automatically by the MCP server

## Troubleshooting

- If you get JSON parsing errors, use the `--args` flag with proper JSON syntax
- Single quotes outside, double quotes inside the JSON: `--args '{"key": "value"}'`
- For complex nested JSON, ensure proper escaping of quotes within the content
- The Notion MCP server handles API version automatically - no need to specify it

## Reference

- View all available Notion MCP tools: `mcporter list notion --schema`
- Notion API documentation: https://developers.notion.com/reference