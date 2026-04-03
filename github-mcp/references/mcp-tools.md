# GitHub MCP Tools Reference

This document lists all 26 tools available in the GitHub MCP server that can be accessed via the mcporter CLI.

## Repository Management
- `create_repository` - Create a new GitHub repository
- `fork_repository` - Fork a repository to your account or organization

## File Operations
- `create_or_update_file` - Create or update a single file in a repository
- `get_file_contents` - Get the contents of a file or directory
- `push_files` - Push multiple files to a repository in a single commit

## Issues
- `create_issue` - Create a new issue
- `get_issue` - Get details of a specific issue
- `list_issues` - List issues with filtering options
- `search_issues` - Search for issues across repositories
- `add_issue_comment` - Add a comment to an existing issue
- `update_issue` - Update an existing issue

## Pull Requests
- `create_pull_request` - Create a new pull request
- `get_pull_request` - Get details of a specific pull request
- `list_pull_requests` - List and filter pull requests
- `merge_pull_request` - Merge a pull request
- `get_pull_request_files` - Get list of files changed in a pull request
- `get_pull_request_status` - Get combined status of all status checks
- `update_pull_request_branch` - Update PR branch with latest base changes
- `get_pull_request_comments` - Get review comments on a pull request
- `get_pull_request_reviews` - Get reviews on a pull request
- `create_pull_request_review` - Create a review on a pull request

## Search
- `search_code` - Search for code across repositories
- `search_issues` - Search for issues and pull requests
- `search_repositories` - Search for repositories
- `search_users` - Search for users on GitHub

## Branches and Commits
- `create_branch` - Create a new branch
- `list_commits` - Get list of commits of a branch

## Usage Examples

To use any of these tools with mcporter:
```bash
mcporter call github.tool_name parameter:value
```

For example:
```bash
mcporter call github.create_repository name:"my-repo" description:"Test repo" private:true
mcporter call github.search_repositories query:"user:HengWeiBin is:private"
mcporter call github.create_issue owner:"HengWeiBin" repo:"myrepo" title:"Bug fix" body:"Fix this issue"
```

To view detailed documentation for all tools:
```bash
mcporter list github --schema
```