pipeline {
    agent any
    tools {
        nodejs "NodeJS" // Name configured in Global Tool Configuration
    }
    environment {
        EC2_IP = "98.80.225.1"
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
                bat '''
                cd todo
                npm install
                npm run build
                '''
            }
        }
        stage("Deploy") {
            steps {
                sshagent(['credential-id']) {
                    bat """
                    "C:\\Program Files\\Git\\bin\\bash.exe" -c \"
                    scp -r todo/build ${EC2_USER}@${EC2_IP}:/home/${EC2_USER}/react-app &&
                    ssh ${EC2_USER}@${EC2_IP} 'sudo rm -rf /var/www/html/* && sudo cp -r /home/${EC2_USER}/react-app/* /var/www/html/ && sudo systemctl restart nginx'
                    \"
                    """
                }
            }
        }
    }
}
