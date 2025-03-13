pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'sujan958/maven-java-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        DOCKER_PATH = '/usr/local/bin/docker' // Explicit Docker path
        PATH = "/usr/local/bin:/opt/homebrew/bin:${PATH}" // Ensure Jenkins finds Docker
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SujanChaudhari/comp367app.git'
            }
        }

        stage('Docker Debug') {
            steps {
                sh 'whoami' // Verify user running Jenkins
                sh 'echo $PATH' // Show Jenkins PATH
                sh '${DOCKER_PATH} --version' // Ensure Jenkins finds Docker
                sh '${DOCKER_PATH} ps' // Verify Docker access
            }
        }

        stage('Docker Login') {
            steps {
                withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: '']) {
                    sh 'echo "Attempting to log in to Docker Hub..."'
                    sh '${DOCKER_PATH} login -u $DOCKER_USER -p $DOCKER_PASS'
                    sh 'echo "Login Successful"'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh "${DOCKER_PATH} build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Docker Push') {
            steps {
                sh "${DOCKER_PATH} push ${DOCKER_IMAGE}"
            }
        }
    }
}
