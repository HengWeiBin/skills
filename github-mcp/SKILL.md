---
name: github-mcp
description: Use the GitHub MCP server via mcporter CLI to interact with GitHub repositories. Use when you need to list repositories, create issues, manage pull requests, search code, or perform any GitHub operations without remembering complex CLI commands. Triggers on phrases like "list my repos", "GitHub operations", "create GitHub issue", "search GitHub code", or when you need to interact with GitHub through the MCP server.
---

# GitHub-MCP Skill

## Overview

This skill provides easy access to GitHub functionality through the Model Context Protocol (MCP) server using the mcporter CLI. It allows you to list repositories, create issues, manage pull requests, and perform other GitHub operations without needing to remember complex CLI commands or authenticate manually.

## Task-Based Operations

This skill follows a task-based structure, offering different GitHub operations as separate capabilities that can be used independently or in combination.

### List Repositories
List your GitHub repositories (public or private) using the GitHub MCP server.

**To list private repositories:**
```bash
mcporter call github.search_repositories query:"user:HengWeiBin is:private"
```

**To list all repositories:**
```bash
mcporter call github.search_repositories query:"user:HengWeiBin"
```

### Create Repository
Create a new GitHub repository in your account.

**To create a new private repository:**
```bash
mcporter call github.create_repository name:"my-new-repo" description:"A new repository" private:true
```

**To create a new public repository with README:**
```bash
mcporter call github.create_repository name:"my-public-repo" description:"A public repository" private:false autoInit:true
```

### Manage Issues
Create, search, and manage GitHub issues.

**To search for open issues:**
```bash
mcporter call github.search_issues q:"repo:HengWeiBin/myrepo state:open"
```

**To create a new issue:**
```bash
mcporter call github.create_issue owner:"HengWeiBin" repo:"myrepo" title:"Bug fix needed" body:"Please fix this bug"
```

### Manage Pull Requests
Work with GitHub pull requests.

**To list open pull requests:**
```bash
mcporter call github.list_pull_requests owner:"HengWeiBin" repo:"myrepo" state:"open"
```

**To create a pull request:**
```bash
mcporter call github.create_pull_request owner:"HengWeiBin" repo:"myrepo" title:"Feature implementation" head:"feature-branch" base:"main"
```

### Search Code
Search for code across your repositories.

**To search for specific code:**
```bash
mcporter call github.search_code q:"function trainModel" repo:"HengWeiBin/MyTorch"
```

### Get File Contents
Retrieve the contents of a file from a repository.

**To get a file's contents:**
```bash
mcporter call github.get_file_contents owner:"HengWeiBin" repo:"myrepo" path:"README.md"
```

### Create or Update Files
Add or modify files in a repository.

**To create or update a file:**
```bash
mcporter call github.create_or_update_file owner:"HengWeiBin" repo:"myrepo" path:"docs/guide.md" content:"# Guide\n\nThis is a guide." message:"Add guide documentation" branch:"main"
```

## Workflow: Common GitHub Tasks

### Setting up a new project
1. Create a new repository: `github.create_repository`
2. Initialize with README: Set `autoInit:true` or create README manually
3. Add project files: Use `create_or_update_file` for multiple files
4. Create initial issue for tracking: `github.create_issue`

### Managing development workflow
1. Create feature branch: Use `github.create_branch` (via direct API call if needed)
2. Make changes and commit: Use `create_or_update_file` or `push_files`
3. Open pull request: `github.create_pull_request`
4. Request reviews: Use review-related endpoints
5. Merge when approved: `github.merge_pull_request`

## Resources

### scripts/
Utility scripts for common GitHub operations using the mcporter CLI.

#### list-private-repos.sh
Lists your private GitHub repositories.
```bash
#!/bin/bash
mcporter call github.search_repositories query:"user:HengWeiBin is:private"
```

#### aliases.sh
Convenient aliases for GitHub MCP operations.
```bash
# List private repositories
alias github-privates='mcporter call github.search_repositories query:"user:HengWeiBin is:private"'

# List all repositories
alias github-repos='mcporter call github.search_repositories query:"user:HengWeiBin"'

# Search repositories
alias github-search='mcporter call github.search_repositories'

# Create repository
alias github-create='mcporter call github.create_repository'

# Search issues
alias github-issues='mcporter call github.search_issues'

# Create issue
alias github-issue-create='mcporter call github.create_issue'

# List pull requests
alias github-prs='mcporter call github.list_pull_requests'

# Create pull request
alias github-pr-create='mcporter call github.create_pull_request'

# Search code
alias github-code-search='mcporter call github.search_code'

# Get file contents
alias github-get-file='mcporter call github.get_file_contents'
```

### references/
Reference documentation for GitHub MCP operations.

#### mcp-tools.md
Reference for all available GitHub MCP tools.

This references the 26 tools available in the GitHub MCP server, including:
- Repository management: create_repository, fork_repository
- File operations: create_or_update_file, get_file_contents, push_files
- Issues: create_issue, get_issue, list_issues, search_issues, add_issue_comment, update_issue
- Pull requests: create_pull_request, get_pull_request, list_pull_requests, merge_pull_request, etc.
- Search: search_code, search_issues, search_repositories, search_users
- Branches: create_branch, list_commits
- Reviews: create_pull_request_review, get_pull_request_review, get_pull_request_reviews

To view all tools with their parameters, run:
```bash
mcporter list github --schema
```

#### authentication.md
Information about GitHub MCP server authentication.

The GitHub MCP server is configured with:
- Username: HengWeiBin
- Personal Access Token: Configured in `/home/weibin/.openclaw/workspace-coder/config/mcporter.json`

No additional authentication is needed when using the mcporter CLI as it reads from the configured MCP server.

### assets/
Template files for GitHub operations.

#### issue-template.md
Template for creating well-structured GitHub issues.
```markdown
## Summary
[Brief description of the issue]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Expected Behavior
[What you expect to happen]

## Actual Behavior
[What actually happens]

## Screenshots
[If applicable, add screenshots here]

## Additional Context
[Any other relevant information]
```

#### pr-template.md
Template for creating pull requests.
```markdown
## Summary
[Brief description of changes]

## Related Issue
[Closes #issue-number] or [Related to #issue-number]

## Changes Made
- [List of changes made]

## Testing
[Description of testing performed]

## Screenshots
[If applicable, add before/after screenshots]
```

## Configuration

The GitHub MCP server is configured in:
- `/home/weibin/.openclaw/workspace-coder/config/mcporter.json`

It uses a personal access token for authentication with username "HengWeiBin".

## Quick Reference Commands

For quick access, you can source the aliases file:
```bash
source /home/weibin/.openclaw/workspace-coder/skills/github-mcp/scripts/aliases.sh
```

Then use:
- `github-privates` - List private repositories
- `github-repos` - List all repositories  
- `github-issue-create "Title" "Description"` - Create an issue
- `github-pr-create "Title" "base:main" "head:feature"` - Create a pull request