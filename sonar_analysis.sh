#!/bin/bash

SONAR_ISSUES=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/measures/component?component=arjit547_react-repo123&metricKeys=bugs" | jq -r '.component.measures[0].value')

if [ "$SONAR_ISSUES" -gt 0 ]; then
  echo "SonarQube analysis found $SONAR_ISSUES issues. Invoking Lambda function..."
  
  # Get detailed issue information
  ISSUES_DETAILS=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/issues/search?componentKeys=arjit547_react-repo123&types=BUG&ps=1" | jq -r '.issues[0].message')

  # Create JSON payload
  PAYLOAD=$(printf '{"exit_status": 1, "issues": "%s"}' "$ISSUES_DETAILS" | base64)
  
  # Invoke Lambda function with issue details
  aws lambda invoke --function-name sonarlambda --payload "$PAYLOAD" output.txt
  
else
  echo "SonarQube analysis succeeded. No issues found."
fi
