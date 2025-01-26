pipeline {
    agent any
    tools {
        nodejs "NodeJS" // Name configured in Global Tool Configuration
    }
    environment {
        EC2_IP = "54.158.217.219"
        EC2_USER = "ubuntu"
    }
    stages {
        stage("Checkout") {
            steps {
                 git branch: "main", url: "https://github.com/akylgit/To-Do.git"
            }
        }
        stage("Build") {
            steps {
                sh '''
                echo "Building the application..."
                cd todo
                npm install
                npm run build
                echo "Build completed successfully."
                '''
            }
        }
        stage("Deploy") {
            steps {
                sshagent(['credential-id']) {
                    script {
                        sh """
                        # Disable host key checking to avoid manual prompts
                        ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'mkdir -p /home/${EC2_USER}/react-app'

                        # Copy the deployment script to the remote server
                        scp -o StrictHostKeyChecking=no deploy.sh ${EC2_USER}@${EC2_IP}:/home/${EC2_USER}/deploy.sh

                        # Copy the React build directory to the remote server
                        scp -r -o StrictHostKeyChecking=no todo/build ${EC2_USER}@${EC2_IP}:/home/${EC2_USER}/react-app

                        # Execute the deployment script on the remote server
                        ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'bash /home/${EC2_USER}/deploy.sh'
                        """
                    }
                }
            }
        }
    }
}

