#!/bin/bash

SONAR_ISSUES_JSON=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/issues/search?componentKeys=arjit547_react-repo123&resolved=false" | jq -r '.issues[] | {key, severity, message}')

if [ "$(echo "$SONAR_ISSUES_JSON" | jq length)" -gt 0 ]; then
  echo "SonarQube analysis found issues. Invoking Lambda function..."
  
  # Create a message with issue details
  MESSAGE="SonarQube analysis found the following issues:"
  MESSAGE+="$(echo "$SONAR_ISSUES_JSON" | jq -r '.[] | "\n\nIssue Key: \(.key)\nSeverity: \(.severity)\nMessage: \(.message)"')"
  
  aws lambda invoke --function-name sonarlambda --payload "{\"exit_status\": 1, \"message\": \"$MESSAGE\"}" output.txt
else
  echo "SonarQube analysis succeeded. No issues found."
fi
