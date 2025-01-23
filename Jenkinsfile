stage("Deploy") {
    steps {
        sshagent(['devops-key']) {
            sh """
            echo "Adding EC2 server to known hosts..."
            ssh-keyscan -H ${EC2_IP} >> ~/.ssh/known_hosts || exit 1

            echo "Starting deployment to ${EC2_IP}..."
            
            # Transfer the build to the EC2 instance
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
