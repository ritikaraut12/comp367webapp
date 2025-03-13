pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'sujan958/maven-java-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        // Define the full path to Docker as found on your system
        DOCKER_CMD = '/Applications/Docker.app/Contents/Resources/bin/docker'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the configured SCM (e.g., GitHub)
                checkout scm
            }
        }
        
        stage('Build Maven Project') {
            steps {
                // Build the Maven project (ensure Maven is installed and in PATH)
                sh 'mvn clean package'
            }
        }
        
        stage('Docker Debug') {
            steps {
                // Use withEnv to force the correct PATH inside this stage
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"]) {
                    sh 'whoami'
                    sh 'echo $PATH'
                    sh "${DOCKER_CMD} --version"
                    sh "${DOCKER_CMD} ps"
                }
            }
        }
        
        stage('Docker Login') {
            steps {
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"]) {
                    sh 'echo "Attempting to log in to Docker Hub..."'
                    // Replace $DOCKER_USER and $DOCKER_PASS with your Docker Hub credentials variables
                    sh "${DOCKER_CMD} login -u $DOCKER_USER -p $DOCKER_PASS"
                    sh 'echo "Login Successful"'
                }
            }
        }
        
        stage('Docker Build') {
            steps {
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"]) {
                    sh "${DOCKER_CMD} build -t ${DOCKER_IMAGE} ."
                }
            }
        }
        
        stage('Docker Push') {
            steps {
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"]) {
                    sh "${DOCKER_CMD} push ${DOCKER_IMAGE}"
                }
            }
        }
    }
}
