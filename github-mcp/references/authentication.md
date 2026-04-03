# GitHub MCP Server Authentication

## Configuration Location

The GitHub MCP server is configured in:
```
/home/weibin/.openclaw/workspace-coder/config/mcporter.json
```

## Current Configuration

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<your-token-here>",
        "GITHUB_USERNAME": "HengWeiBin"
      }
    }
  },
  "imports": []
}
```

## Authentication Details

- **Username**: HengWeiBin
- **Personal Access Token**: Configured and stored securely in the MCP server configuration
- **Token Permissions**: The token should have sufficient permissions for repository operations (repo scope recommended)

## How Authentication Works

When you use the mcporter CLI to call GitHub tools:
```bash
mcporter call github.search_repositories query:"user:HengWeiBin is:private"
```

The MCP server automatically uses the configured credentials from the environment variables in the mcporter.json file. No additional authentication steps are required from the user side.

## Security Notes

- The personal access token is stored in plain text in the configuration file
- Ensure your workspace directory has appropriate file permissions
- Consider rotating the token periodically for security
- The token should be treated as sensitive information

## Testing Authentication

To verify authentication is working, you can run:
```bash
mcporter call github.search_repositories query:"user:HengWeiBin is:private"
```

If authentication is working correctly, you should see a list of your private repositories without any authentication errors.