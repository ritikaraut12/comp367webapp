pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ritikaraut12/comp367webapp.git'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean package'  // ✅ Use 'bat' for Windows
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying the application..."
            }
        }
    }
}
