pipeline {
    agent any

    environment {
        // Docker image name and tag
        DOCKER_IMAGE = 'sujan958/maven-java-app:latest'
        // Docker command path (ensure this is correct for your system)
        DOCKER_CMD = '/usr/bin/docker' // Updated to a more common path
        // Docker Hub credentials (use Jenkins credentials ID)
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Replace with your Jenkins credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull source code from your configured SCM (GitHub, etc.)
                checkout scm
            }
        }

        stage('Build Maven Project') {
            steps {
                // Ensure Maven is installed and in PATH
                sh 'mvn clean package'
            }
        }

        stage('Docker Debug') {
            steps {
                // Debugging: Check Docker setup
                sh 'echo "Current user: $(whoami)"'
                sh 'echo "PATH is: $PATH"'
                sh "${DOCKER_CMD} --version"
                sh "${DOCKER_CMD} images"
                sh "${DOCKER_CMD} ps -a"
            }
        }

        stage('Docker Login') {
            steps {
                // Log in to Docker Hub using Jenkins credentials
                withCredentials([usernamePassword(
                    credentialsId: env.DOCKER_CREDENTIALS_ID,
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo "Attempting to log in to Docker Hub..."
                        ${DOCKER_CMD} login -u ${DOCKER_USER} -p ${DOCKER_PASS}
                        echo "Login Successful"
                    """
                }
            }
        }

        stage('Docker Build') {
            steps {
                // Build the Docker image
                sh "${DOCKER_CMD} build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Docker Push') {
            steps {
                // Push the Docker image to Docker Hub
                sh "${DOCKER_CMD} push ${DOCKER_IMAGE}"
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check the logs for details."
        }
        cleanup {
            // Clean up Docker resources (optional)
            sh "${DOCKER_CMD} system prune -f"
        }
    }
}