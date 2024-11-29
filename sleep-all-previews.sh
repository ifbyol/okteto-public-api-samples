#!/bin/bash

token=${OKTETO_TOKEN}
base_url=${OKTETO_URL}/api/v0

response=$(curl -X 'GET' -sS -w "%{http_code}" "${base_url}/namespaces?type=preview" -H 'accept: application/json' -H 'Authorization: Bearer '"$token")

http_code=$(tail -n1 <<< "$response")
previews=$(sed '$ d' <<< "$response")

if [ "$http_code" -ne 200 ]; then
  echo "Failed to retrieve previews. HTTP code: $http_code, response: '$previews'"
  exit 1
fi

echo "$previews" | jq -c -r '.[]' | while IFS= read -r preview; do
  name=$(echo "$preview" | jq -r '.name')
  status=$(echo "$preview" | jq -r '.status')
  persistent=$(echo "$preview" | jq -r '.persistent')

  if [ "$status" = "Sleeping" ]; then
    echo "Preview '$name' is already sleeping"
  elif [ "$persistent" = "true" ]; then
      echo "Namespace $name is persistent, so it won't be put to sleep"
  else
    echo "Preview '$name' is going to sleep"
    okteto preview sleep "$name"
  fi
done
