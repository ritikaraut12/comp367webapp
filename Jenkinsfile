pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'sujan958/maven-java-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        // We still set PATH for Maven and other commands, but for Docker we'll use DOCKER_CMD.
        PATH = "/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        // Explicitly set the Docker socket (if required)
        DOCKER_HOST = "unix:///Users/mac/.docker/run/docker.sock"
        // Set the full Docker command path
        DOCKER_CMD = "/Applications/Docker.app/Contents/Resources/bin/docker"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout source code from the SCM configured for this job
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
                // Debug output to verify environment variables and Docker command access
                sh 'whoami'
                sh 'echo $PATH'
                sh '${DOCKER_CMD} --version'
                sh '${DOCKER_CMD} ps'
            }
        }

        stage('Docker Login') {
            steps {
                withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: '']) {
                    sh 'echo "Attempting to log in to Docker Hub..."'
                    sh '${DOCKER_CMD} login -u $DOCKER_USER -p $DOCKER_PASS'
                    sh 'echo "Login Successful"'
                }
            }
        }

        stage('Docker Build') {
            steps {
                // Build the Docker image using the Dockerfile in the project root
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
}
