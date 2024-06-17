#!/bin/bash
set -e

if [[ -z "$EI_PROJECT_API_KEY" ]]; then
    echo "Missing EI_PROJECT_API_KEY env variable"
    exit 1
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    --project-id)
      PROJECT_ID="$2"
      shift # past argument
      shift # past value
      ;;
    --sample-id)
      SAMPLE_ID="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      shift # past argument
      ;;
  esac
done

if [[ -z "$PROJECT_ID" ]]; then
    echo "Missing --project-id variable"
    exit 1
fi
if [[ -z "$SAMPLE_ID" ]]; then
    echo "Missing --sample-id variable"
    exit 1
fi

echo "Updating project $PROJECT_ID, sample $SAMPLE_ID..."

curl -X POST "https://studio.edgeimpulse.com/v1/api/$PROJECT_ID/raw-data/$SAMPLE_ID/structured-labels" \
    -H "Content-Type: application/json" \
    -H "x-api-key: $EI_PROJECT_API_KEY" \
    --data-raw '{"structuredLabels":[{"label":"first_label","startIndex":0,"endIndex":125},{"label":"second_label","startIndex":125,"endIndex":313},{"label":"third_label","startIndex":313,"endIndex":621}]}'
