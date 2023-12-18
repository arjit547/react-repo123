#!/bin/bash

SONAR_ISSUES=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/issues/search?componentKeys=arjit547_react-repo123&resolved=false" | jq -r '.issues | .[] | .message')

if [ -n "$SONAR_ISSUES" ]; then
  echo "SonarQube analysis found issues. Invoking Lambda function..."
  PAYLOAD=$(echo -n "{\"exit_status\": 1, \"issues\": \"$SONAR_ISSUES\"}" | base64)
  aws lambda invoke --function-name sonarlambda --payload "$PAYLOAD" output.txt
else
  echo "SonarQube analysis succeeded. No issues found."
fi
