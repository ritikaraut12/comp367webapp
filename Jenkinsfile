pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ritikaraut/maven-java-app:latest'
        DOCKER_CMD = 'docker'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ritikaraut12/comp367webapp.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Docker Debug') {
            steps {
                bat 'echo Current user: %USERNAME%'
                bat 'echo PATH is: %PATH%'
                bat "${DOCKER_CMD} --version"
                bat "${DOCKER_CMD} images"
                bat "${DOCKER_CMD} ps -a"
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat """
                        echo Logging in to Docker Hub...
                        echo %DOCKER_PASS% | ${DOCKER_CMD} login -u %DOCKER_USER% --password-stdin
                        echo Login Successful
                    """
                }
            }
        }

        stage('Docker Build') {
            steps {
                bat "${DOCKER_CMD} build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Docker Push') {
            steps {
                bat "${DOCKER_CMD} push ${DOCKER_IMAGE}"
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
        cleanup {
            bat "${DOCKER_CMD} system prune -f"
        }
    }
}
ritika
