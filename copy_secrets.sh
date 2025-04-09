#!/bin/bash

VAULT_SOURCE="dev/firstSecret"
VAULT_TARGET="dev/secondSecret"

copy_secrets_recursively () {
  local source_path="$1"
  local target_path="$2"

  items=$(vault kv list -format=json "$source_path" | jq -r '.[]')

  for item in $items; do
    if [[ "$item" == */ ]]; then
      copy_secrets_recursively "${source_path}/${item%/}" "${target_path}/${item%/}"
    else
      echo "Copying secret: ${source_path}/${item} -> ${target_path}/${item}"

      secret_data=$(vault kv get -format=json "${source_path}/${item}" | jq '.data')
      if [[ $? -ne 0 ]]; then
        echo "Error retrieving secret ${source_path}/${item}, skipping."
        continue
      fi

      echo "$secret_data" | vault kv put "${target_path}/${item}" -
      if [[ $? -ne 0 ]]; then
        echo "Error writing secret ${target_path}/${item}, please check permissions."
      fi
    fi
  done
}

copy_secrets_recursively "$VAULT_SOURCE" "$VAULT_TARGET"
