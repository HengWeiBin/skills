# List private repositories
alias github-privates='mcporter call github.search_repositories query:"user:<your-github-username> is:private"'

# List all repositories
alias github-repos='mcporter call github.search_repositories query:"user:<your-github-username>"'

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