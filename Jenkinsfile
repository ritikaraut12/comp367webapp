
pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'sujan958/maven-java-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Add this in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                 git branch: 'main', url: 'https://github.com/SujanChaudhari/comp367app.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Login') {
            steps {
                withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: '']) {
                    sh 'echo Logged into Docker Hub'
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
