#!/bin/bash

token=${OKTETO_TOKEN}
base_url=${OKTETO_URL}/api/v0

# Check if there is any pod using the PVC
handle_pvc() {
  pvc_name=$(echo "$1" | jq -r '.metadata.name')
  namespace_name=$2
  pod_name=$(kubectl get pods -n "$namespace_name" -o json | jq -r --arg pvc "$pvc_name" '.items[] | select(any(.spec.volumes[]?; .persistentVolumeClaim?.claimName == $pvc)) | .metadata.name')

    if [ -n "$pod_name" ]; then
      echo "pvc '$pvc_name' is being used by pod '$pod_name' in namespace '$namespace_name'. Skipping deletion"
      return
    fi

    echo "deleting dev pvc '$pvc_name' in namespace '$namespace_name' as it is not being used"
    kubectl delete pvc "$pvc_name" -n "$namespace_name"
}

# Retrieve all namespaces of "development" type
response=$(curl -X 'GET' -sS -w "%{http_code}" "${base_url}/namespaces?type=development" -H 'accept: application/json' -H 'Authorization: Bearer '"$token")

http_code=$(tail -n1 <<< "$response")
namespaces=$(sed '$ d' <<< "$response")

# Check if the request was successful
if [ "$http_code" -ne 200 ]; then
  echo "Failed to retrieve namespaces. HTTP code: $http_code, response: '$namespaces'"
  exit 1
fi

# create temporary directory to store kubeconfig for the script and not interfere with the current one
tmp_dir=$(mktemp -d)
export KUBECONFIG=$tmp_dir/kubeconfig

# Setting the kubeconfig to the okteto context
okteto kubeconfig

echo "$namespaces" | jq -c -r '.[]' | while IFS= read -r namespace; do
  name=$(echo "$namespace" | jq -r '.name')

  # retrieve PVCs within the namespace that were created by Okteto
  pvcs=$(kubectl get pvc -l dev.okteto.com -n "$name" -o json | jq -c -r '.items[]')

  if [ -z "$pvcs" ]; then
    echo "no dev pvc found in namespace '$name'."
    echo "------------------------------------------------------"
    continue
  fi

  echo "checking dev pvcs on namespace '$name'"

  echo "$pvcs" | while IFS= read -r pvc; do
    handle_pvc "$pvc" "$name"
  done

  # namespace separator
  echo "------------------------------------------------------"
done

# remove the temporary directory
rm -Rf "$tmp_dir"