#!/bin/bash
set -e
# Deploy React app
echo "Deploying React app to EC2 instance..."

sudo rm -rf /var/www/html/*
sudo cp -r /home/ubuntu/react-app/build/* /var/www/html/
sudo systemctl restart nginx

echo "Deployment complete!"