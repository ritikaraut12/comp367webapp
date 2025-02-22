pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/ritikaraut12/comp367webapp.git'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean package'  // Use 'bat' instead of 'sh' for Windows
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying the application..."
            }
        }
    }
}

