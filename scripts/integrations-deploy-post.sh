
#!/bin/bash

if [ "$DEPLOYMENT_GROUP_NAME" == "nodesymk" ]; then
    if [ -e /home/my-temp-dir/.env ]; then
        echo "Waiting for 2 minutes...."
        sleep 120
        cp -R /home/my-temp-dir/. /var/www/html
        rm -rf /home/my-temp-dir
        chown -R ubuntu:ubuntu /var/www/html
        cd /var/www/html
        npm install
        #npm install -g pkg

        # Run npm build and check its exit code
        npm run build

        if [ $? -ne 0 ]; then
            echo "Error: npm run build failed."
        fi
    else
        cp -R /home/my-temp-dir/. /var/www/html
        rm -rf /home/my-temp-dir
        chown -R ubuntu:ubuntu /var/www/html
        cd /var/www/html
        npm install
        #npm install -g pkg

        # Run npm build and check its exit code
        npm run build

        if [ $? -ne 0 ]; then
            echo "Error: npm run build failed."
        fi
    fi

    # Install SonarQube Scanner globally
    npm install -g sonarqube-scanner@latest

    # Run SonarQube Scanner
    sonar-scanner -Dsonar.projectKey=arjit547_react-repo123 -Dsonar.organization=arjit547 -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=9222105b2c25c8770ac2dcde96ffc8c9a979a65c -Dsonar.qualitygate.wait=true
fi
