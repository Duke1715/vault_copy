# Vault Secrets Recursive Copier (KV v1)

This script recursively copies all secrets from one path to another in a HashiCorp Vault (KV version 1) instance.

## Prerequisites

- `vault` CLI installed and configured.
- `jq` installed.

### Install Dependencies

```bash
# For Ubuntu/Debian
sudo apt install jq

# For CentOS/RHEL
sudo yum install jq

# For MacOS
brew install jq
```

## Usage

### Step 1: Adjust variables

Modify the following variables inside `copy_secrets.sh` to match your paths:

```bash
VAULT_SOURCE="dev/firstSecret"
VAULT_TARGET="dev/secondSecret"
```

### Step 2: Make script executable

```bash
chmod +x copy_secrets.sh
```

### Step 3: Run the script

```bash
./copy_secrets.sh
```

## Notes

- Ensure your Vault token or environment has sufficient permissions:
  - Read permissions on the source path.
  - Write permissions on the target path.
- This script is designed specifically for Vault KV v1. If you're using KV v2, adjustments to paths and API calls will be required.

## Error Handling

The script will output errors encountered during secret retrieval or writing but will continue processing remaining secrets.

## Recommended Testing

Test the script in a non-production environment or on a small subset of secrets to ensure expected behavior.
