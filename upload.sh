#!/bin/bash
set -e

if [[ -z "$EI_PROJECT_API_KEY" ]]; then
    echo "Missing EI_PROJECT_API_KEY env variable"
    exit 1
fi

curl -X POST \
    -H "x-api-key: $EI_PROJECT_API_KEY" \
    -H "Content-Type: multipart/form-data" \
    -F "data=@updown.3.json" \
    -F "data=@structured_labels.labels" \
    https://ingestion.edgeimpulse.com/api/training/files
