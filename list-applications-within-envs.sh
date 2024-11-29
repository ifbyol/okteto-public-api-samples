#!/bin/bash

token=${OKTETO_TOKEN}
base_url=${OKTETO_URL}/api/v0

list_applications() {
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

    if [ -z "${repository}" ]; then
        echo "    - Application '$name' has no repository"
    else
        echo "    - Application '$name' deployed from repository '$repository'"
    fi
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

  echo "Getting applications for namespace '$name':"

  list_applications "$name"
  if [ $? -ne 0 ]; then
      echo "Failed to list applications for namespace $name"
      continue
  fi
done