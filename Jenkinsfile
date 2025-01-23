pipeline {
    agent any
    tools {
        nodejs "NodeJS"  // This is configured in Global Tool Configuration
    }
    stages {
        stage("Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/akylgit/To-Do.git'
            }
        }
        stage("Install and Build") {
            steps {
                withEnv(["NODE_HOME=${tool 'NodeJS'}", "PATH+NODE=${tool 'NodeJS'}/bin"]) {
                    bat 'npm install'
                    bat 'npm run build'
                }
            }
        }
        stage("Deploy") {
            steps {
                withEnv(["NODE_HOME=${tool 'NodeJS'}", "PATH+NODE=${tool 'NodeJS'}/bin"]) {
                    // Deployment commands that use NodeJS
                    bat 'npm run deploy'
                }
            }
        }
    }
}
