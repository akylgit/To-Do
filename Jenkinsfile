pipeline {
    agent any
    tools {
        nodejs "NodeJS" // Name configured in Global Tool Configuration
    }
    environment {
        EC2_IP = "98.81.133.13"
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
                cd todo
                npm install
                npm run build
                '''
            }
        }
        stage("Deploy") {
            steps {
                sshagent(['credential-id']) {
                    sh """
                    scp -r todo/build ${EC2_USER}@${EC2_IP}:/home/${EC2_USER}/react-app
                    ssh ${EC2_USER}@${EC2_IP} << EOF
                    # Update package lists and install Nginx
                    sudo apt-get update -y
                    sudo apt-get install -y nginx

                    # Clean the Nginx web root and deploy the React app
                    sudo rm -rf /var/www/html/*
                    sudo cp -r /home/${EC2_USER}/react-app/* /var/www/html/

                    # Restart Nginx to apply changes
                    sudo systemctl restart nginx
                    EOF
                    """
                }
            }
        }
    }
}
