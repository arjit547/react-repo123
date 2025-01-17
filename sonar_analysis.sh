#!/bin/bash
 
# Fetch SonarQube token from AWS CodeBuild environment variable
SONAR_TOKEN="$SONAR_TOKEN"
SONAR_PROJECT_KEY="arjit547_react-repo123"
 
SONAR_ISSUES=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/measures/component?component=${SONAR_PROJECT_KEY}&metricKeys=bugs" | jq -r '.component.measures[0].value')
 
if [ "$SONAR_ISSUES" -gt 0 ]; then
  echo "SonarQube analysis found $SONAR_ISSUES issues. Invoking Lambda function..."
  PAYLOAD=$(echo -n "{\"exit_status\": 1, \"issues\": \"$SONAR_ISSUES\"}" | base64)
  aws lambda invoke --function-name sonarlambda --payload "$PAYLOAD" output.txt
else
  echo "SonarQube analysis succeeded. No issues found."
fi
