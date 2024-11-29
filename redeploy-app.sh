#!/bin/bash

# This script looks for all applications within namespaces managed by Okteto that match
# with the provided repository and branch and redeploy them if they were not updated in the
# last 24 hours to make sure they are up to date with the latest changes in the repository.

# It is the repository to look for an application. It should be the format owner/repository. e.g okteto/movies
target_repo=$1
# It is the branch to look for an application. e.g main. If branch is not provided, it won't
# match branch and will redeploy all applications that match with the repository.
target_branch=$2

# Check if the target repository is provided
if [ -z "$target_repo" ]; then
    echo "Usage: $0 <owner>/<repository>"
    exit 1
fi

token=${OKTETO_TOKEN}
base_url=${OKTETO_URL}/api/v0

# Function to extract the owner/repository from a git URL
extract_owner_repo() {
  local url="$1"

  # Remove the optional .git suffix
  url="${url%.git}"

  local owner_repo=""

  # Match SSH URLs, e.g., git@github.com:owner/repo
  if [[ "$url" =~ ^git@[^:]+:(.+)$ ]]; then
      owner_repo="${BASH_REMATCH[1]}"

  # Match HTTPS URLs, e.g., https://github.com/owner/repo
  elif [[ "$url" =~ ^https?://[^/]+/(.+)$ ]]; then
      owner_repo="${BASH_REMATCH[1]}"

  # Match Git protocol URLs, e.g., git://github.com/owner/repo
  elif [[ "$url" =~ ^git://[^/]+/(.+)$ ]]; then
      owner_repo="${BASH_REMATCH[1]}"
  fi

  echo "$owner_repo"
}

handle_applications() {
  namespace_name=$1
  apps_endpoint="${base_url}/namespaces/${namespace_name}/applications"

  response=$(curl -X 'GET' -sS -w "%{http_code}" "${apps_endpoint}" -H 'accept: application/json' -H 'Authorization: Bearer '"$token")

  http_code=$(tail -n1 <<< "$response")
  apps=$(sed '$ d' <<< "$response")

  if [ "$http_code" -ne 200 ]; then
      echo "Failed to retrieve apps for namespace $namespace_name. HTTP code: $http_code, response: '$apps'"
      exit 1
  fi

  echo "$apps" | jq -c -r '.[]' | while IFS= read -r app; do
    name=$(echo "$app" | jq -r '.name')
    repository=$(echo "$app" | jq -r '.repository // ""') # provide default value to empty string if no repo is found
    branch=$(echo "$app" | jq -r '.branch // ""') # provide default value to empty string if no branch is found
    updated_time=$(echo "$app" | jq -r '.lastUpdated')

    # if there is not repo in the application, we just pass to check the next one
    if [ -z "${repository}" ]; then
        continue
    fi

    # if the repository doesn't match, we just skip the application
    owner_repo=$(extract_owner_repo "$repository")
    if [ "$owner_repo" != "$target_repo" ]; then
        continue
    fi

    # if the branch doesn't match, we just skip the application
    if [ -n "$target_branch" ] && [ "$branch" != "$target_branch" ]; then
        continue
    fi

    last_update_epoch=$(gdate -d "$updated_time" +%s)
    threshold_epoch=$(gdate -d "1 minutes ago" +%s)

    if [ "$last_update_epoch" -ge "$threshold_epoch" ]; then
      echo "Application '$name' was updated recently. Skipping it"
      continue
    fi

    echo "Redeploying application '$name' deployed from repository '$repository' and branch '$branch'"

    # using --reuse-params to keep the same labels and variables than the previous deployment
    okteto pipeline deploy -n "$namespace_name" --name "$name" --repository "$repository" --branch "$branch" --reuse-params --wait=false
  done
}

response=$(curl -X 'GET' -sS -w "%{http_code}" "${base_url}/namespaces?type=development" -H 'accept: application/json' -H 'Authorization: Bearer '"$token")

http_code=$(tail -n1 <<< "$response")
namespaces=$(sed '$ d' <<< "$response")

if [ "$http_code" -ne 200 ]; then
    echo "Failed to retrieve namespaces. HTTP code: $http_code, response: '$namespaces'"
    exit 1
fi

echo "$namespaces" | jq -c -r '.[]' | while IFS= read -r namespace; do
  name=$(echo "$namespace" | jq -r '.name')

  echo "Checking applications for namespace '$name'"

  handle_applications "$name"
  if [ $? -ne 0 ]; then
      echo "Failed to list applications for namespace $name"
      continue
  fi

  echo "------------------------------------------------------"
done