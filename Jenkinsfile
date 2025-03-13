pipeline {
    agent any

    environment {
        // Docker image name and tag
        DOCKER_IMAGE = 'sujan958/maven-java-app:latest'
        // Full path to Docker
        DOCKER_CMD = '/Applications/Docker.app/Contents/Resources/bin/docker'
        // Jenkins credentials ID
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Debug') {
            steps {
                sh 'echo "Current user: $(whoami)"'
                sh 'echo "PATH is: $PATH"'
                sh "${DOCKER_CMD} --version"
                sh "${DOCKER_CMD} images"
                sh "${DOCKER_CMD} ps -a"
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: env.DOCKER_CREDENTIALS_ID,
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo "Attempting to log in to Docker Hub..."
                        echo \$DOCKER_PASS | ${DOCKER_CMD} login -u \$DOCKER_USER --password-stdin
                        echo "Login Successful"
                    """
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh "${DOCKER_CMD} build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Docker Push') {
            steps {
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
            sh "${DOCKER_CMD} system prune -f"
        }
    }
}
