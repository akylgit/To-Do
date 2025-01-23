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
                sshagent(['devops-key']) {
                    sh """
                    echo "Starting deployment to ${EC2_IP}..."
                    
                    # Transfer the build to the EC2 instances
                    scp -r todo/build ${EC2_USER}@${EC2_IP}:/home/${EC2_USER}/react-app || exit 1

                    # SSH into the EC2 instance and configure Nginx
                    ssh ${EC2_USER}@${EC2_IP} << EOF
                    echo "Updating and installing Nginx..."
                    sudo apt-get update -y || exit 1
                    sudo apt-get install -y nginx || exit 1
                    
                    echo "Deploying React app..."
                    sudo rm -rf /var/www/html/*
                    sudo cp -r /home/${EC2_USER}/react-app/* /var/www/html/ || exit 1
                    sudo systemctl restart nginx || exit 1

                    echo "Deployment successful."
                    EOF
                    """
                }
            }
        }
    }
}
