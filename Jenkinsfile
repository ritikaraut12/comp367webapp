pipeline {
    agent any

    environment {
        // Docker image name and tag (update with your Docker Hub username)
        DOCKER_IMAGE = 'ritikaraut/maven-java-app:latest'
        // Use 'docker' command (assumed to be in PATH on Windows)
        DOCKER_CMD = 'docker'
        // Jenkins credentials ID for Docker Hub
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                // Check out source code from SCM (Git)
                checkout scm
            }
        }

        stage('Build Maven Project') {
            steps {
                // Build the Maven project; ensure Maven is installed and in PATH
                bat 'mvn clean package'
            }
        }

        stage('Docker Debug') {
            steps {
                // Debug: show current user and PATH, check Docker version, images, and running containers
                bat 'echo Current user: %USERNAME%'
                bat 'echo PATH is: %PATH%'
                bat "${DOCKER_CMD} --version"
                bat "${DOCKER_CMD} images"
                bat "${DOCKER_CMD} ps -a"
            }
        }

        stage('Docker Login') {
            steps {
                // Log in to Docker Hub using Jenkins credentials
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat """
                        echo Attempting to log in to Docker Hub...
                        echo %DOCKER_PASS% | ${DOCKER_CMD} login -u %DOCKER_USER% --password-stdin
                        echo Login Successful
                    """
                }
            }
        }

        stage('Docker Build') {
            steps {
                // Build the Docker image using the Dockerfile in the project root
                bat "${DOCKER_CMD} build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Docker Push') {
            steps {
                // Push the Docker image to Docker Hub
                bat "${DOCKER_CMD} push ${DOCKER_IMAGE}"
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
            bat "${DOCKER_CMD} system prune -f"
        }
    }
}
