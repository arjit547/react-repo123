#!/bin/bash

SONAR_ISSUES=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/measures/component?component=arjit547_react-repo123&metricKeys=bugs" | jq -r '.component.measures[0].value')

if [ "$SONAR_ISSUES" -gt 0 ]; then
  echo "SonarQube analysis found $SONAR_ISSUES issues. Invoking Lambda function..."

  # Escape special characters in the issues details
  ISSUES_DETAILS=$(echo "$SONAR_ISSUES" | sed 's/"/\\"/g')

  PAYLOAD="{\"exit_status\": 1, \"issues\": \"$ISSUES_DETAILS\"}"

  # Base64 encode the payload
  ENCODED_PAYLOAD=$(echo -n "$PAYLOAD" | base64)

  aws lambda invoke --function-name sonarlambda --payload "$ENCODED_PAYLOAD" output.txt
else
  echo "SonarQube analysis succeeded. No issues found."
fi
