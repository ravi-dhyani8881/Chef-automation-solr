#!/bin/bash

# Ensure the configuration directories and files exist
if [ ! -f /var/chef/config/solo.rb ]; then
    echo "solo.rb not found!"
    exit 1
fi

if [ ! -f /var/chef/config/web.json ]; then
    echo "web.json not found!"
    exit 1
fi

# Run Chef-Solo


# Change to the repository directory
cd /var/chef/output/gitRepo

# Configure Git for the current repository
git config user.email "ravi.dhyani@mulesoft.com"
git config user.name "ravi-dhyani8881"

git pull origin "$BRANCH_NAME"

chef-solo -c /var/chef/config/solo.rb -j /var/chef/config/web.json

# Check for changes
git_status=$(git status --porcelain)

if [ -n "$git_status" ]; then
    echo "Changes detected, proceeding with git add, commit, and push."

    # Stage changes
    git fetch origin
    git rebase origin/"$BRANCH_NAME"
    #git pull origin "$BRANCH_NAME"
    git add .

    # Commit changes
    git commit -m "Automated commit by Docker container" .

    # Push changes using the GitHub token for authentication
    if [ -n "$GITHUB_TOKEN" ]; then
        git push https://"$GITHUB_TOKEN"@github.com/ravi-dhyani8881/solr-docker.git "$BRANCH_NAME"
    else
        echo "GITHUB_TOKEN is not set. Skipping push."
    fi
else
    echo "No changes detected, skipping git add, commit, and push."
fi

# Execute any additional commands passed to the entry point
exec "$@"
