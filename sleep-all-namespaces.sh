#!/bin/bash

token=${OKTETO_TOKEN}
base_url=${OKTETO_URL}/api/v0

response=$(curl -X 'GET' -sS -w "%{http_code}" "${base_url}/namespaces?type=development" -H 'accept: application/json' -H 'Authorization: Bearer '$token)

http_code=$(tail -n1 <<< "$response")
namespaces=$(sed '$ d' <<< "$response")

if [ "$http_code" -ne 200 ]; then
  echo "Failed to retrieve namespaces. HTTP code: $http_code, response: '$namespaces'"
  exit 1
fi

echo "$namespaces" | jq -c -r '.[]' | while IFS= read -r namespace; do
  name=$(echo "$namespace" | jq -r '.name')
  status=$(echo "$namespace" | jq -r '.status')
  persistent=$(echo "$namespace" | jq -r '.persistent')

  if [ "$status" = "Sleeping" ]; then
    echo "Namespace $name is already sleeping"
  elif [ "$persistent" = "true" ]; then
    echo "Namespace $name is persistent, so it won't be put to sleep"
  else
    echo "Namespace $name is going to sleep"
    okteto namespace sleep "$name"
  fi
done