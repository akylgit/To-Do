pipeline {
    agent any
    tools {
        nodejs "NodeJS" // Name configured in Global Tool Configuration
    }
    environment {
        EC2_IP = "3.85.55.17"
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
                    sh '''
                    # Ensure target directories exist on EC2
                    ssh ${EC2_USER}@${EC2_IP} "mkdir -p /home/ubuntu/react-app"

                    # Copy the deploy.sh file to EC2
                    scp deploy.sh ${EC2_USER}@${EC2_IP}:/home/${EC2_USER}/deploy.sh

                    
                    # Transfer the build to the EC2 instances
                    scp -r todo/build ${EC2_USER}@${EC2_IP}:/home/${EC2_USER}/react-app || exit 1

                     # Run the deploy.sh script on EC2
                    ssh ${EC2_USER}@${EC2_IP} "bash /home/${EC2_USER}/deploy.sh"
                            '''

                
                }
            }
        }
    }
}

