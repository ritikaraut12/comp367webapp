pipeline {
    agent any

    environment {
        // Adjust these as needed:
        DOCKER_IMAGE = 'sujan958/maven-java-app'
        // Path to Docker on your system:
        DOCKER_CMD = '/Applications/Docker.app/Contents/Resources/bin/docker'
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
                // Force PATH to include /usr/local/bin, etc.
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"]) {
                    sh 'whoami'
                    sh 'echo "PATH is: $PATH"'
                    sh "${DOCKER_CMD} --version"
                    sh "${DOCKER_CMD} ps"
                }
            }
        }

        stage('Docker Login') {
            steps {
                // Manual login to Docker Hub
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"]) {
                    sh 'echo "Attempting to log in to Docker Hub..."'
                    // Replace $DOCKER_USER and $DOCKER_PASS with your environment variables or Jenkins credentials
                    sh "${DOCKER_CMD} login -u $DOCKER_USER -p $DOCKER_PASS"
                    sh 'echo "Login Successful"'
                }
            }
        }

        stage('Docker Build') {
            steps {
                // Build the Docker image
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"]) {
                    sh "${DOCKER_CMD} build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                // Push the Docker image
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"]) {
                    sh "${DOCKER_CMD} push ${DOCKER_IMAGE}"
                }
            }
        }
    }
}
