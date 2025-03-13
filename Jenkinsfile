pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'sujan958/maven-java-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        PATH = "/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        DOCKER_HOST = "unix:///Users/mac/.docker/run/docker.sock" // Explicitly set Docker socket
    }

    stages {
        stage('Docker Debug') {
            steps {
                sh 'whoami' // Check Jenkins user
                sh 'echo $PATH' // Debug PATH
                sh 'docker --version' // Ensure Jenkins finds Docker
                sh 'docker ps' // Verify Docker access
            }
        }

        stage('Docker Login') {
            steps {
                withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: '']) {
                    sh 'echo "Attempting to log in to Docker Hub..."'
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                    sh 'echo "Login Successful"'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Docker Push') {
            steps {
                sh "docker push ${DOCKER_IMAGE}"
            }
        }
    }
}
