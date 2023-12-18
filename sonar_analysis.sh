#!/bin/bash

# Fetch SonarQube token from AWS CodeBuild environment variable
SONAR_TOKEN="$SONAR_TOKEN"
SONAR_PROJECT_KEY="arjit547_react-repo123"

# Fetch SonarQube analysis details
SONAR_DETAILS=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/qualitygates/project_status?projectKey=${SONAR_PROJECT_KEY}" | jq -r '.projectStatus.status')

# Fetch SonarQube issues count for new code
SONAR_NEW_ISSUES=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/measures/component?component=${SONAR_PROJECT_KEY}&metricKeys=new_bugs" | jq -r '.component.measures[0].value')

# Fetch SonarQube issues count for overall code
SONAR_OVERALL_ISSUES=$(curl -s -u "${SONAR_TOKEN}": -X GET "https://sonarcloud.io/api/measures/component?component=${SONAR_PROJECT_KEY}&metricKeys=bugs" | jq -r '.component.measures[0].value')

if [ "$SONAR_DETAILS" == "OK" ]; then
  echo "SonarQube analysis passed quality gate. No issues found."
else
  echo "SonarQube analysis failed quality gate. Invoking Lambda function..."
  PAYLOAD=$(echo -n "{\"exit_status\": 1, \"quality_gate_status\": \"$SONAR_DETAILS\", \"new_code_issues\": \"$SONAR_NEW_ISSUES\", \"overall_code_issues\": \"$SONAR_OVERALL_ISSUES\"}" | base64)
  aws lambda invoke --function-name sonarlambda --payload "$PAYLOAD" output.txt
fi
