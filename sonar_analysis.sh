#!/bin/bash
 
SONAR_ISSUES=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/measures/component?component=arjit547_react-repo123&metricKeys=bugs" | jq -r '.component.measures[0].value')
 
if [ "$SONAR_ISSUES" -gt 0 ]; then
  echo "SonarQube analysis found $SONAR_ISSUES issues. Invoking Lambda function..."
  PAYLOAD=$(echo -n "{\"exit_status\": 1}" | base64)
  INVOKE_OUTPUT=$(aws lambda invoke --function-name sonarlambda --payload "$PAYLOAD" output.txt 2>&1)
  echo "Lambda function output: $INVOKE_OUTPUT"
else
  echo "SonarQube analysis succeeded. No issues found."
fi
