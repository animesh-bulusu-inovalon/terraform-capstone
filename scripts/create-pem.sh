#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <KeyName>"
  exit 1
fi

KEY_NAME=$1
PEM_FILE="${KEY_NAME}.pem"

# Create the key‑pair, extract just the KeyMaterial, write to file
aws ec2 create-key-pair \
  --key-name "${KEY_NAME}" \
  --query 'KeyMaterial' \
  --output text > "${PEM_FILE}"

# Make it executable
chmod +x "${PEM_FILE}"
# move the pem file to one level up
mv "${PEM_FILE}" ../"${PEM_FILE}"