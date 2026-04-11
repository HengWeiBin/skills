# GitHub MCP Server Authentication

## Configuration

The GitHub MCP server should be configured in your `mcporter.json` file. The location of this file depends on your setup:

- **Project-level config:** `./config/mcporter.json` in your workspace
- **System-level config:** `~/.mcporter/mcporter.json`

## Example Configuration

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
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<your-github-token>",
        "GITHUB_USERNAME": "<your-github-username>"
      }
    }
  },
  "imports": []
}
```

## Authentication Details

- **Username**: `<your-github-username>` - Your GitHub username
- **Personal Access Token**: `<your-github-token>` - A GitHub personal access token with appropriate scopes

### Token Permissions

The token should have at least the following scopes:
- `repo` - Full control of private repositories (if accessing private repos)
- `read:org` - Read organization data (if working with orgs)

## How Authentication Works

When you use the mcporter CLI to call GitHub tools:
```bash
mcporter call github.search_repositories query:"user:<your-github-username> is:private"
```

The MCP server automatically uses the configured credentials from the environment variables in your `mcporter.json` file. No additional authentication steps are required.

## Security Best Practices

1. **Never commit tokens**: Keep your `mcporter.json` out of version control by adding it to `.gitignore`
2. **Use environment variables**: Consider loading tokens from environment variables instead of hardcoding
3. **Rotate tokens regularly**: Generate new tokens periodically and revoke old ones
4. **Limit token scopes**: Only grant the minimum permissions needed
5. **Secure file permissions**: Restrict access to your config file

### Using Environment Variables

Instead of hardcoding the token, you can reference environment variables:

```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_actual_token"
export GITHUB_USERNAME="your_username"
```

Then reference them in your config or let the MCP server pick them up automatically.

## Testing Authentication

To verify authentication is working, run:
```bash
mcporter call github.search_repositories query:"user:<your-github-username> is:private"
```

If authentication is working correctly, you should see a list of your private repositories without any authentication errors.

## Troubleshooting

### Authentication Errors

If you see authentication errors:
1. Verify your token is valid at https://github.com/settings/tokens
2. Check that the token has sufficient permissions
3. Ensure your username is correct
4. Verify the `mcporter.json` file is properly formatted

### Token Expired

GitHub tokens can expire. If your token expires:
1. Generate a new token at https://github.com/settings/tokens
2. Update your `mcporter.json` with the new token
3. Restart any services using the MCP server